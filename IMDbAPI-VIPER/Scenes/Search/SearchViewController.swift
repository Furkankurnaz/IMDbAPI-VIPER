//
//  SearchViewController.swift
//  IMDbAPI-VIPER
//
//  Created by Furkan Kurnaz on 17.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SeachViewProtocol {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var filterView: RoundedView!
    @IBOutlet weak var typePickButton: UIButton!
    @IBOutlet weak var yearPickButton: UIButton!
    
    @IBOutlet weak var pickerContentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: - Properties
    
    private var types: [String] = [
        "Movies",
        "Series",
        "Episode"
    ]
    
    private var years: [String] = []
    
    private var isFilterViewShowing: Bool = false
    private var currentPickerViewType: PickerViewType = .type
    
    private var selectedType: String = ""
    private var selectedYear: String = ""
    
    var presenter: SearchPresenterProtocol!
    
    var searchResults: SearchModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func handleOutput(_ output: SearchPresenterOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showMediaList(let searchResults):
            self.searchResults = searchResults
        }
    }
    
    // MARK: - Helpers
    
    private func configureView() {
        self.filterView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
        hideFilterView()
        hidePickerView()
        getPickerViewDatas()
    }
    
    private func getPickerViewDatas() {
        let currentYear = Calendar.current.component(.year, from: Date())
            
        for year in 1900 ... currentYear {
            years.insert(String(year), at: 0)
        }
    }
    
    private func showFilterView() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.filterView.transform = .identity
        },
                       completion: nil)
    }
    
    private func hideFilterView() {
        UIView.animate(withDuration: 0.5) {
            self.filterView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showPickerView() {
        self.pickerContentView.transform = .identity
        pickerView.reloadAllComponents()
    }
    
    private func hidePickerView() {
        self.pickerContentView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
    }
    
    // MARK: - Actions
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        isFilterViewShowing = false
        hideFilterView()
        searchTextField.resignFirstResponder()
        
        if searchTextField.text?.count == 0 {
            showAlert(title: "Error", message: "The name field cannot be blank.")
        } else {
            presenter.load(title: searchTextField.text ?? "", type: selectedType, year: selectedYear)
        }
    }
    
    @IBAction func filtersButtonTapped(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        
        isFilterViewShowing = !isFilterViewShowing
        
        if isFilterViewShowing {
            showFilterView()
        } else {
            hideFilterView()
        }
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
    
    @IBAction func pickButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            currentPickerViewType = .type
        case 1:
            currentPickerViewType = .year
        default: break
        }
        
        UIView.animate(withDuration: 0.3) {
            self.showPickerView()
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            typePickButton.setTitle("Pick...", for: .normal)
        case 1:
            yearPickButton.setTitle("Pick...", for: .normal)
        default: break
        }
    }
    
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        hideFilterView()
        isFilterViewShowing = false
        
        if let typeText = typePickButton.titleLabel?.text {
            if typeText != "Pick..." {
                selectedType = typeText
            } else {
                selectedType = ""
            }
        }
        
        if let yearText = yearPickButton.titleLabel?.text {
            if yearText != "Pick..." {
                selectedYear = yearText
            } else {
                selectedYear = ""
            }
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.hidePickerView()
        }
        
        let index = pickerView.selectedRow(inComponent: 0)
        switch currentPickerViewType {
        case .type:
            let title = types[index]
            typePickButton.setTitle(title, for: .normal)
        case .year:
            let title = years[index]
            yearPickButton.setTitle(title, for: .normal)
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideFilterView()
        isFilterViewShowing = false
    }
}

// MARK: - UIPickerViewDataSource

extension SearchViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch currentPickerViewType {
        case .type:
            return types.count
        case .year:
            return years.count
        }
    }
}

// MARK: - UIPickerViewDelegate

extension SearchViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch currentPickerViewType {
        case .type:
            return types[row]
        case .year:
            return years[row]
        }
    }
}

enum PickerViewType {
    case type
    case year
}

//
//  MediaListViewController.swift
//  IMDbAPI-VIPER
//
//  Created Furkan Kurnaz on 23.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//


import UIKit

class MediaListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MediaListPresenter!
    
    var medias: SearchModel?

	override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.load()
        configureView()
    }
    
    private func configureView() {
        tableView.rowHeight = 100
    }

}

extension MediaListViewController: MediaListViewProtocol {
    func update(presentation: SearchModel) {
        self.medias = presentation
        tableView.reloadData()
    }
}

extension MediaListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medias?.search.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title: String = medias?.search[indexPath.row].title ?? ""
        let type: String = medias?.search[indexPath.row].type ?? ""
        let imageURL: String = medias?.search[indexPath.row].poster ?? ""
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MediaListTableViewCell
        
        cell.setView(title: title, type: type, imageURL: imageURL)
        
        return cell
    }
}

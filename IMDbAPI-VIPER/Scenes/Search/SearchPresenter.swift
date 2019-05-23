//
//  SearchPresenter.swift
//  IMDbAPI-VIPER
//
//  Created by Furkan Kurnaz on 17.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    
    private let view: SeachViewProtocol
    private let interactor: SearchInteractorProtocol
    private let router: SearchRouterProtocol
    
    init(view: SeachViewProtocol,
         interactor: SearchInteractorProtocol,
         router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.interactor.delegate = self
        
        view.handleOutput(.updateTitle("IMDb Search"))
    }
    
    func getYearDatas() {
        interactor.getTypeDatas()
    }
    
    func getTypeDatas() {
        interactor.getYearDatas()
    }
    
    func load(title: String, type: String?, year: String?) {
        interactor.load(title: title, type: type, year: year)
    }
    
    func validateNameField(name: String?) {
        if let name = name {
            if name.count > 0 {
                view.handleOutput(.isValidName(true))
            } else {
                view.handleOutput(.isValidName(false))
            }
        } else {
            view.handleOutput(.isValidName(false))
        }
    }
}

extension SearchPresenter: SearchInteractorDelegate {
    func handleOutput(_ output: SearchInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showMediaList(let medias):
            view.handleOutput(.showMediaList(medias))
        case .showYears(let years):
            view.handleOutput(.showYears(years))
        case .showTypes(let types):
            view.handleOutput(.showTypes(types))
        }
    }
}

//
//  SearchPresenter.swift
//  IMDbAPI-VIPER
//
//  Created by Furkan Kurnaz on 17.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    
    private unowned let view: SeachViewProtocol
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
    
    func load(title: String, type: String?, year: String?) {
        interactor.load(title: title, type: type, year: year)
    }
}

extension SearchPresenter: SearchInteractorDelegate {
    func handleOutput(_ output: SearchInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showMediaList(let medias):
            view.handleOutput(.showMediaList(medias))
        }
    }
}

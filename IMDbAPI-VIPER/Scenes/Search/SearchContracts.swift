//
//  SearchContracts.swift
//  IMDbAPI-VIPER
//
//  Created by Furkan Kurnaz on 17.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import Foundation

// MARK: - View

protocol SeachViewProtocol: class {
    func handleOutput(_ output: SearchPresenterOutput)
}

// MARK: - Interactor

protocol SearchInteractorProtocol: class {
    var delegate: SearchInteractorDelegate? { get set }
    func load(title: String, type: String?, year: String?)
}

protocol SearchInteractorDelegate: class {
    func handleOutput(_ output: SearchInteractorOutput)
}

enum SearchInteractorOutput {
    case setLoading(Bool)
    case showMediaList(SearchModel)
}

// MARK: - Presenter

protocol SearchPresenterProtocol: class {
    func load(title: String, type: String?, year: String?)
}

enum SearchPresenterOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showMediaList(SearchModel)
}

// MARK: - Router

protocol SearchRouterProtocol: class {
    func navigate(to route: SearchRoute)
}

enum SearchRoute {
    case list(SearchModel)
}

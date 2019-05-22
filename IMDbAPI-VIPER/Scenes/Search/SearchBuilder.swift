//
//  SearchBuilder.swift
//  IMDbAPI-VIPER
//
//  Created by Furkan Kurnaz on 17.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

final class SearchBuilder {
    static func make() -> SearchViewController {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let router = SearchRouter(view: view)
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(view: view,
                                           interactor: interactor,
                                           router: router)
        view.presenter = presenter
        return view
    }
}

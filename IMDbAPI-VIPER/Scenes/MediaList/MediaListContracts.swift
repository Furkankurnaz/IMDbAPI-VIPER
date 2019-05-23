//
//  MediaListContracts.swift
//  IMDbAPI-VIPER
//
//  Created Furkan Kurnaz on 23.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import Foundation

// MARK: View
protocol MediaListViewProtocol: class {
    func update(presentation: SearchModel)
}

// MARK: Presenter
protocol MediaListPresenterProtocol: class {
    func load()
}

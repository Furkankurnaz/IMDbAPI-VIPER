//
//  SearchRouter.swift
//  IMDbAPI-VIPER
//
//  Created by Furkan Kurnaz on 17.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

final class SearchRouter: SearchRouterProtocol {
    
    let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: SearchRoute) {
        switch route {
        case .list(let searchModel):
            let listView = MediaListBuilder.make(media: searchModel)
            view.show(listView, sender: nil)
        }
    }
}

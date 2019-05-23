//
//  MediaListBuilder.swift
//  IMDbAPI-VIPER
//
//  Created Furkan Kurnaz on 23.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

class MediaListBuilder {
    static func make(media: SearchModel) -> MediaListViewController {
        let storyBoard = UIStoryboard(name: "MediaList", bundle: nil)
        let view: MediaListViewController = storyBoard.instantiateViewController(withIdentifier: "MediaListViewController") as! MediaListViewController
        let presenter = MediaListPresenter(view: view, media: media)
        
        view.presenter = presenter
        
        return view
    }
}

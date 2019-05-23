//
//  SearchInteractor.swift
//  IMDbAPI-VIPER
//
//  Created by Furkan Kurnaz on 17.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import Foundation
import Moya

final class SearchInteractor: SearchInteractorProtocol {
    
    weak var delegate: SearchInteractorDelegate?
    
    func getYearDatas() {
        var years: [String] = []
        
        let currentYear = Calendar.current.component(.year, from: Date())
        
        for year in 1900 ... currentYear {
            years.insert(String(year), at: 0)
        }
        
        self.delegate?.handleOutput(.showYears(years))
    }
    
    func getTypeDatas() {
        let types: [String] = [
            "Movies",
            "Series",
            "Episode"
        ]
        
        self.delegate?.handleOutput(.showTypes(types))
    }
    
    func load(title: String, type: String?, year: String?) {
        delegate?.handleOutput(.setLoading(true))
        
        let pluginsArray:[PluginType] = [NetworkLoggerPlugin(cURL: true)]
        let provider = MoyaProvider<IMDbAPIService>(plugins: pluginsArray)
        
        provider.request(.search(title: title, type: type, year: year)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let value):
                let data = value.data
                
                do {
                    let results = try JSONDecoder().decode(SearchModel.self, from: data)
                    self.delegate?.handleOutput(.showMediaList(results))
                } catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

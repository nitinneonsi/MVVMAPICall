//
//  ArticleViewModel.swift
//  SampleAppJTT
//
//  Created by Nitz on 18/06/20.
//  Copyright © 2020 JTT. All rights reserved.
//

import Foundation
import UIKit

class ArticleViewModel {
    
    var media = [Media]()
    var user = [User]()
    let jsonHelper = JsonHelper()
    
    func getDataFromAPI(completion: @escaping ([Articles]) -> Void) {
        jsonHelper.getAPIData(completion: {response  in
            
            
            completion(response)
        })
    }
}

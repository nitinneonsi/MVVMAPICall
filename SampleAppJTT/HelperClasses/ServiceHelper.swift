//
//  ServiceHelper.swift
//  SampleAppJTT
//
//  Created by Nitz on 18/06/20.
//  Copyright © 2020 JTT. All rights reserved.
//

import Foundation

class JsonHelper {
    
    var articleResponse = [Articles]()
//    var media = [Media]()
//    var user = [User]()
    func getAPIData(completion: @escaping ([Articles]) -> Void) {
        
        let urlStr = URL(string: "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=1&limit=10")
        URLSession.shared.dataTask(with: urlStr!) { (data, response, error) in
            
            guard data != nil else{return}
            
            do {
                
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([Articles].self, from: data!)
                
                self.articleResponse.append(contentsOf: responseModel)
                
                completion(self.articleResponse)
            }
            catch{
                print(error.localizedDescription)
            }
            }.resume()
    }
}

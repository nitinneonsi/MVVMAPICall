//
//  ServiceHelper.swift
//  SampleAppJTT
//
//  Created by Nitz on 18/06/20.
//  Copyright © 2020 JTT. All rights reserved.
//

import Foundation

class ServiceHelper {
    
    var articleResponse = [Articles]()
    let numberOfItemsPerPage = 10
    
    func getAPIData(page: Int, completion: @escaping ([Articles]) -> Void) {
        
        let urlStr = URL(string: "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=\(page)&limit=10")
//        print("URL REQUEST : ", urlStr!)
        URLSession.shared.dataTask(with: urlStr!) { (data, response, error) in
            
            guard data != nil else{return}
        
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([Articles].self, from: data!)
                
                self.articleResponse.append(contentsOf: responseModel)
//                print("Response : ", self.articleResponse)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let firstIndex = page * self.numberOfItemsPerPage
                    guard firstIndex < self.articleResponse.count else {
                        completion([])
                        return
                    }
                    let lastIndex = (page + 1) * self.numberOfItemsPerPage < self.articleResponse.count ?
                        (page + 1) * self.numberOfItemsPerPage : self.articleResponse.count
                    completion(Array(self.articleResponse[firstIndex ..< lastIndex]))
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

//
//  ViewController.swift
//  SampleAppJTT
//
//  Created by Nitz on 18/06/20.
//  Copyright © 2020 JTT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var media = [Media]()
    var user = [User]()
    var articles = [Articles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let articleVM = ArticleViewModel()
        
        articleVM.getDataFromAPI(completion: {[weak self] response in
            
            self?.articles = response
            
            //print("Response = \(String(describing: self?.articles))")
            
        })
    }
}


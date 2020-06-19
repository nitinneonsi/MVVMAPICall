//
//  ViewController.swift
//  SampleAppJTT
//
//  Created by Nitz on 18/06/20.
//  Copyright © 2020 JTT. All rights reserved.
//

import UIKit
import PagingTableView

class ViewController: UIViewController {

    @IBOutlet weak var tableViewArticles: PagingTableView!
    
    let articleVM = ArticleViewModel()
    let jsonHelper = ServiceHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewArticles.pagingDelegate = self
    }
}

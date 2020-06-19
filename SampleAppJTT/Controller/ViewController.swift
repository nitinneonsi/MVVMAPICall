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

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonHelper.articleResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewArticles.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        
        let article = jsonHelper.articleResponse[indexPath.row]
        cell.articlesCell = article
        cell.configCell()
        
        return cell
    }
}



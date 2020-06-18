//
//  ViewController.swift
//  SampleAppJTT
//
//  Created by Nitz on 18/06/20.
//  Copyright © 2020 JTT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewArticles: UITableView!

    let articleVM = ArticleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleVM.vc = self
        articleVM.loadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleVM.jsonHelper.articleResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewArticles.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        
        let article = articleVM.jsonHelper.articleResponse[indexPath.row]
        cell.articlesCell = article
        cell.configCell()
        
        return cell
    }
}


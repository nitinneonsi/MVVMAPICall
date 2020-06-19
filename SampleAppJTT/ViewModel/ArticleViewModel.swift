//
//  ArticleViewModel.swift
//  SampleAppJTT
//
//  Created by Nitz on 18/06/20.
//  Copyright © 2020 JTT. All rights reserved.
//

import Foundation
import UIKit
import PagingTableView

class ArticleViewModel {
    
    // Mark: Formatting number for likes and comments
    func formatNumber(_ n: Int) -> String {
        
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""
        
        switch num {
            
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)B"
            
        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)M"
            
        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)K"
            
        case 0...:
            return "\(n)"
            
        default:
            return "\(sign)\(n)"
        }
    }
}

extension Double {
    
    func truncate(places: Int) -> Double {
        
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
        
    }
}

extension String {
    // Mark: Formatting date
    func toDate(withFormat format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        return date
    }
}

extension Date {
    // Mark: Calculating time passed from the created date
    func timeAgoSinceDate() -> String {
        
        // From Time
        let fromDate = self
        // To Time
        let toDate = Date()
        
        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "year" : "\(interval)" + " " + "years"
        }
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "month" : "\(interval)" + " " + "months"
        }
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "day" : "\(interval)" + " " + "days"
        }
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "hour" : "\(interval)" + " " + "hours"
        }
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "min" : "\(interval)" + " " + "mins"
        }
        return "just now"
    }
}

extension ViewController: UITableViewDataSource {
    // Mark: TableView Data Source
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

extension ViewController: PagingTableViewDelegate {
    // Mark: Load more data (Pagination)
    func paginate(_ tableView: PagingTableView, to page: Int) {
        tableViewArticles.isLoading = true
        jsonHelper.getAPIData(page: page+1) { Articles in
            self.jsonHelper.articleResponse.append(contentsOf: Articles)
            self.tableViewArticles.isLoading = false
        }
    }
}

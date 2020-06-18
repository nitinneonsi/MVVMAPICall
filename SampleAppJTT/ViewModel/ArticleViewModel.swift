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
    
    weak var vc : ViewController?
    let jsonHelper = ServiceHelper()
    
    func loadData()  {
        jsonHelper.getAPIData(completion: {[weak self] response in
            
            DispatchQueue.main.async {
                self?.vc?.tableViewArticles.reloadData()
            }
        })
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

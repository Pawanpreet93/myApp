//
//  WhyWWDCInterfaceController.swift
//  Pawanpreet Singh
//
//  Created by Pawanpreet Singh on 28/04/16.
//  Copyright © 2016 Pawanpreet Singh. All rights reserved.
//

import WatchKit
import Foundation


class WhyWWDCInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    private let tableData = ["print(\"Hello, Apple!\")","A lifechanging experience.","/* help me to deepen my love with Hands on Labs */","1 Infinity Loop ❤️","Fraternize.","Dream Fulfil.","Like minded community.","/* Love to see enhancements in Apple Watch OS, News App */","Best week in Best Company."]
    private let textColors = [UIColor(red: 0.153, green: 0.631, blue: 0.929, alpha: 1.00),
                              UIColor(red: 0.000, green: 0.992, blue: 0.996, alpha: 1.00),
                              UIColor(red: 0.000, green: 0.976, blue: 0.298, alpha: 1.00),
                              UIColor(red: 0.973, green: 0.000, blue: 0.149, alpha: 1.00),
                              UIColor(red: 0.996, green: 0.980, blue: 0.318, alpha: 1.00),
                              UIColor(red: 1.000, green: 0.337, blue: 0.929, alpha: 1.00),
                              UIColor(red: 0.435, green: 0.639, blue: 0.976, alpha: 1.00),
                              UIColor(red: 0.000, green: 0.976, blue: 0.298, alpha: 1.00),
                              UIColor(red: 0.996, green: 0.620, blue: 0.212, alpha: 1.00)]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        tableView.setNumberOfRows(tableData.count, withRowType: "WWDCRow")
        
        for i in 0 ..< tableData.count {
            if let row = tableView.rowControllerAtIndex(i) as? WWDCRow {
                row.titleLabel.setText(tableData[i])
                row.titleLabel.setTextColor(textColors[i])
            }
        }
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}

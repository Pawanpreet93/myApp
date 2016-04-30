//
//  CInterfaceController.swift
//  Pawanpreet Singh
//
//  Created by Pawanpreet Singh on 28/04/16.
//  Copyright © 2016 Pawanpreet Singh. All rights reserved.
//

import WatchKit
import Foundation


class CInterfaceController: WKInterfaceController {

    @IBOutlet weak var graphGroup: WKInterfaceGroup!
    private let duration = 1.2
    private var appeared = false

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        

        // Configure interface objects here.
    }

    override func willActivate() {
        super.willActivate()
        
    }

    override func didAppear() {
        if !appeared{
        graphGroup.setBackgroundImageNamed("c")
        graphGroup.startAnimatingWithImagesInRange(NSMakeRange(0, 61), duration: duration, repeatCount: 1)
            appeared = true
        }


    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

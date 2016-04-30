//
//  InterfaceController.swift
//  Pawanpreet Singh Watch App Extension
//
//  Created by Pawanpreet Singh on 28/04/16.
//  Copyright © 2016 Pawanpreet Singh. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var myFaceImageView: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Success)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}

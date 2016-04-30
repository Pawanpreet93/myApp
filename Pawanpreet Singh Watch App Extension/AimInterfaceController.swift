//
//  AimInterfaceController.swift
//  Pawanpreet Singh
//
//  Created by Pawanpreet Singh on 28/04/16.
//  Copyright © 2016 Pawanpreet Singh. All rights reserved.
//

import WatchKit
import Foundation


class AimInterfaceController: WKInterfaceController {

    @IBOutlet var imageOne: WKInterfaceImage!
    @IBOutlet var label1: WKInterfaceLabel!
    @IBOutlet var label2: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        imageOne.setImageNamed("aimPic")
        
        label1.setText("At the age of 15, I entered the realm of coding. I spent hours learning new things. In the 8th standard, I decided to do Computer Engineering after my school education. After that there was no looking back.  I always create short term goals and aim to fulfill them.\n\nTalking about my long term goals, being a social work lover, me and my friend have planned of making a free multi-speciality hospital only for poor people in my city. Now about my field that is Development, I have aimed to involve people from the Slum area, make them learn and be employed. I feel that if a person is having a good skill set and good logic building then he/she can develop anything and you never know that can be the Next Steve Jobs!!")
        
        label2.setText("Working on my dream, I celebrated my 21st birthday by spending time in slums and helped them in realising the importance of education. I also participated in Technical Fest to raise funds and with that I adopted 4 orphans and now I funded their study and schooling expenditure for two years.\n\nDescribing a bit more about me is my \"daily goal setting\" habit. This includes making someone around me happy or at least make them smile.")
    
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

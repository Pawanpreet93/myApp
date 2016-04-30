//
//  AboutMeInterfaceController.swift
//  Pawanpreet Singh
//
//  Created by Pawanpreet Singh on 28/04/16.
//  Copyright © 2016 Pawanpreet Singh. All rights reserved.
//

import WatchKit
import Foundation


class AboutMeInterfaceController: WKInterfaceController {

    @IBOutlet var imageOne: WKInterfaceImage!
    @IBOutlet var imageTwo: WKInterfaceImage!
    @IBOutlet var label1: WKInterfaceLabel!
    @IBOutlet var label2: WKInterfaceLabel!
    @IBOutlet var label3: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        imageOne.setImageNamed("aboutMe")
        imageTwo.setImageNamed("steveJobs")
        
        label1.setText("Hi! I am Pawanpreet Singh. I am 22 years old, App and Web Developer from Patiala,India. I have done my schooling from Sri Aurobindo International School, Patiala. Presently, I am pursuing my Bachelor's degree from Punjabi University, Patiala.")
        label2.setText("I was introduced to the world of PCs in the early 2000s and my father bought me my own PC in 2002. In the beginning I was very well impressed my this wondrous machine by working on Paint and FoxPro.  Later on at age of 15 with the introduction of coding at school, I began learning by my own which marked the end of my Gaming arena and beginning of the Coding phase. With few tags I could make my own webpages and show it to my mates.")
        label3.setText("My idol is Mr. Steven Paul Jobs. I had always dreamt of meeting him but unfortunately I couldn't. He inspired me and stimulated in me the dream of working for Apple one day. I follow his ideology, work principles and passion towards making things awesome.")
        
        
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

//
//  AcademicsInterfaceController.swift
//  Pawanpreet Singh
//
//  Created by Pawanpreet Singh on 28/04/16.
//  Copyright © 2016 Pawanpreet Singh. All rights reserved.
//

import WatchKit
import Foundation


class AcademicsInterfaceController: WKInterfaceController {

    @IBOutlet var schoolMap: WKInterfaceMap!
    @IBOutlet var collegeMap: WKInterfaceMap!
    @IBOutlet var schoolParaOne: WKInterfaceLabel!
    @IBOutlet var schoolParaTwo: WKInterfaceLabel!
    @IBOutlet var collegeParaOne: WKInterfaceLabel!
    @IBOutlet var collegeParaTwo: WKInterfaceLabel!

    @IBOutlet var commonParagraph: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        commonParagraph.setText("It is rightly said that a person keeps on learning things everyday. Learning starts right from the moment when  we are in the mother's womb and continues till our death.  My academic journey started when I was 2.5 years old kid and after travelling a long road my journey of education is going to end this August (If I don't opt for Masters)")
        
        schoolParaOne.setText("It was 1st April,1996 when my schooling started with a smile and excitement to learn something new along with everyone around me crying for being away from their parents. It was an astonishing journey which marked its end in 2012.")
        
        let schoolLocation = CLLocationCoordinate2DMake(30.338240,76.404003)
        let schoolSpan = MKCoordinateSpan(latitudeDelta: 0.003,longitudeDelta: 0.003)
        let schoolRegion = MKCoordinateRegion(center: schoolLocation, span: schoolSpan)
        
        schoolMap.setRegion(schoolRegion)
        schoolMap.addAnnotation(schoolLocation, withPinColor: WKInterfaceMapPinColor.Purple)
        
        schoolParaTwo.setText("I was awarded with a student with Scientific Attitude and Leadership Qualities in the school. I was State level player of Yoga and participated in many Science Exhibitions.")
        
        collegeParaOne.setText("As already being told, I am currently pursuing my Bachelor's degree from Punjabi University, Patiala in Computer Engineering. It is 50 years old University and a home of First Cycling Track of India. College faculty has always been supportive. My teachers have always encouraged me to be a good programmer.")
        
        let collegeLocation = CLLocationCoordinate2DMake(30.359330,76.444807)
        let collegeSpan = MKCoordinateSpan(latitudeDelta: 0.003,longitudeDelta: 0.003)
        let collegeRegion = MKCoordinateRegion(center: collegeLocation, span: collegeSpan)
        
        collegeMap.setRegion(collegeRegion)
        collegeMap.addAnnotation(collegeLocation, withPinColor: WKInterfaceMapPinColor.Purple)
        
        collegeParaTwo.setText("At the University level, I founded a Technical club named \"Explogrammers\". My team has organised numerous coding events.  We have also launched India's First Technical Magazine by Students named \"E-Tech\". I have also hosted an iOS Development Workshop in my University. Apart from this I have also participated in a number of events and have won many.\n\nMy college journey was full of new experiences and developing new interests. Bachelor's degree will be marked as achieved in the coming August.")
        
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

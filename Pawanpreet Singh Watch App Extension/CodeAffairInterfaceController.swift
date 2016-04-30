//
//  CodeAffairInterfaceController.swift
//  Pawanpreet Singh
//
//  Created by Pawanpreet Singh on 28/04/16.
//  Copyright © 2016 Pawanpreet Singh. All rights reserved.
//

import WatchKit
import Foundation


class CodeAffairInterfaceController: WKInterfaceController {

    @IBOutlet var languageParagraph: WKInterfaceLabel!
    @IBOutlet var projectParagraph: WKInterfaceLabel!
   
    @IBOutlet var languageTable: WKInterfaceTable!
    @IBOutlet var projectTable: WKInterfaceTable!
    
    private let languageTimelineData = ["HTML$With this knowledge,I started developing webpages with the guidance of my school teacher and used those to tease my sister and be hero in front of my friends.",
                                        
                                        "C and C++$This was the first language that made me fall for the programming. On the first day itself I bought books and started learning them. I developed simple games like tic tac toe with the help of  this.",
                                        
                                        "Objective C$The time I got my MacBook Pro, I thought to utilize it do develop iOS Apps and for that I started learning it from the YouTube videos and using Apple Developer portal. I never had any coaching of this. And later on I resoluted to build my career as an iOS App Developer.",
                                        
                                        "C#$For the Summer Internship due to lack of any iOS app development company around me I opted for C# and ended up being Microsoft Certified Professional and Microsoft Technology Associate.",
                                        
                                        "CSS$Working on one of my projects I learnt this to beautify my pages.",
                                        
                                        "Swift$After being introduced to App developers in 2014 I just dropped Objective C and started learning Swift. It was fun learning it on Playground.",
                                        
                                        "JS$I started learning this as a part time in my internship to connect UI of website to their backend."]
    
    private let projectTimelineData = ["Telephone Directory$Developed using C++ and allowing the user to add,update, delete and Search  the directory of contact numbers and addresses.",
                                       
                                       "eDoctor$A website developed using .NET framework along with MS SQL Server that allows user to search a specialist doctor in its vicinity.",
                                       
                                       "C Questions$An iOS App created using Objective C. It is a basic quiz app covering some important topics of C language along with the answers. It also has cloud database for storing errors and feedbacks submitted by user.",
                                       
                                       "Data Structures$Built using Swift language and is also supported on Apple Watch which helps the user to learn Data structure in a very innovative and step by step manner using gestures.",
                                       
                                       " Clenergize$Developed iPhone and iPad apps for my Friend's startup.",
                                       
                                       "Data Structures Step by Step$Windows version of Data Structures iOS App."]
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    
        languageParagraph.setText("I was introduced to programming language at the age of 15 when I was in 8th standard. After that it was no looking back.  In 2002 I got my first PC and I was in love with it. After my school I got My first Apple Product - MacBook Pro as a gift and after that I cant imagine my life without Apple Product (its more like an Apple obsession now!!). The following timeline will tell you about my journey of learning programming languages.")
        projectParagraph.setText("Now about the projects, from the age of 15, I used to practice in building Webpages and used to tease my elder sister. Then after I started my undergraduate degree, I used to work on real world applications stated below.")
        
        languageTable.setNumberOfRows(languageTimelineData.count, withRowType: "LanguageTimelineRow")
        projectTable.setNumberOfRows(projectTimelineData.count, withRowType: "ProjectsTimelineRow")
        
        for i in 0 ..< languageTimelineData.count {
            let splitIntoArray = languageTimelineData[i].characters.split{$0 == "$"}.map(String.init)

            if let row = languageTable.rowControllerAtIndex(i) as? TimelineRow {
                row.titleLabel.setText(splitIntoArray[0])
                row.descLabel.setText(splitIntoArray[1])
            }
        }
        
        for i in 0 ..< projectTimelineData.count {
            let splitIntoArray = projectTimelineData[i].characters.split{$0 == "$"}.map(String.init)
            
            if let row = projectTable.rowControllerAtIndex(i) as? TimelineRow {
                row.titleLabel.setText(splitIntoArray[0])
                row.descLabel.setText(splitIntoArray[1])
            }
        }
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

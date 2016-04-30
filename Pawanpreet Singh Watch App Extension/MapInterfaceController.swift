//
//  MapInterfaceController.swift
//  Pawanpreet Singh
//
//  Created by Pawanpreet Singh on 28/04/16.
//  Copyright © 2016 Pawanpreet Singh. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation


class MapInterfaceController: WKInterfaceController {

    @IBOutlet var myMapView: WKInterfaceMap!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let location = CLLocationCoordinate2DMake(30.370631, 76.381854)
        let span = MKCoordinateSpan(latitudeDelta: 0.003,longitudeDelta: 0.003)
        let region = MKCoordinateRegion(center: location, span: span)

        myMapView.setRegion(region)
        myMapView.addAnnotation(location, withPinColor: WKInterfaceMapPinColor.Purple)
   
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

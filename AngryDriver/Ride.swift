//
//  Ride.swift
//  AngryDriver
//
//  Created by David Prochazka on 02/04/16.
//  Copyright © 2016 David Prochazka. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Ride: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    static func createRide(line: String, rating: Int) -> Ride {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Ride", inManagedObjectContext: managedObjectContext)
        
        let tmpRide = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Ride
        
        tmpRide.line = line
        tmpRide.rating = rating
        
        do {
            try managedObjectContext.save()
        } catch {
            abort()
        }
        
        return tmpRide
    }
}

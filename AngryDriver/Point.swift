//
//  Point.swift
//  AngryDriver
//
//  Created by David Prochazka on 02/04/16.
//  Copyright © 2016 David Prochazka. All rights reserved.
//

import Foundation
import CoreData

import UIKit


class Point: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    static func createPoint(lat: Double, lon: Double, accX: Double, accY: Double, accZ: Double, timestamp: NSDate) -> Point {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Point", inManagedObjectContext: managedObjectContext)
        let tmpPoint = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Point
    
        tmpPoint.timestamp = timestamp
        tmpPoint.accX = accX
        tmpPoint.accY = accY
        tmpPoint.accZ = accZ
        tmpPoint.lat = lat
        tmpPoint.lon = lon
        
        do {
            try managedObjectContext.save()
        } catch {
            abort()
        }
        
        return tmpPoint
    }
    
    static func createPoint(point: TmpPoint) -> Point {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Point", inManagedObjectContext: managedObjectContext)
        let tmpPoint = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Point
        
        tmpPoint.timestamp = point.timestamp
        tmpPoint.accX = point.accX
        tmpPoint.accY = point.accY
        tmpPoint.accZ = point.accZ
        tmpPoint.lat = point.lat
        tmpPoint.lon = point.lon
        
        do {
            try managedObjectContext.save()
        } catch {
            abort()
        }
        
        return tmpPoint
    }

}

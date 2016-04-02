//
//  Point+CoreDataProperties.swift
//  AngryDriver
//
//  Created by David Prochazka on 02/04/16.
//  Copyright © 2016 David Prochazka. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Point {

    @NSManaged var lat: NSNumber?
    @NSManaged var lon: NSNumber?
    @NSManaged var accX: NSNumber?
    @NSManaged var accY: NSNumber?
    @NSManaged var accZ: NSNumber?
    @NSManaged var timestamp: NSDate?
    @NSManaged var ride: Ride?

}

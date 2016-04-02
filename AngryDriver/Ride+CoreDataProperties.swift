//
//  Ride+CoreDataProperties.swift
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

extension Ride {

    @NSManaged var line: String?
    @NSManaged var rating: NSNumber?
    @NSManaged var points: Set<Point>?
    @NSManaged var synced: NSNumber?

}

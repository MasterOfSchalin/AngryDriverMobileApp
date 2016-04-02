//
//  ViewController.swift
//  AngryDriver
//
//  Created by David Prochazka on 01/04/16.
//  Copyright © 2016 David Prochazka. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {

    var managedObjectContext: NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init MOC
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func syncData(sender: AnyObject) {
        print("Hooooooo XXX")

        let rides = self.fetchedResultsController.fetchedObjects as! [Ride]
        for ride in rides{
            print("Hooooooo")
            sendToServer(ride)
            //ride.synced = true
        }
        
        do {
            try self.managedObjectContext!.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            // print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }
    
    
    func sendToServer(ride: Ride){
        var ref = Firebase(url: "https://vivid-torch-6344.firebaseio.com/")
        var rideRef = ref.childByAutoId()
        
        var pointRecords = [[String: String]]()
        
        if let points = ride.points {
            
            for point in points {
                var pointRecord = [String: String]()
                pointRecord["lat"] = point.lat!.description
                pointRecord["lon"] = point.lon!.description
                pointRecord["accX"] = point.accX!.description
                pointRecord["accY"] = point.accY!.description
                pointRecord["accZ"] = point.accZ!.description
                pointRecord["timestamp"] = point.timestamp!.description
                pointRecords.append(pointRecord)
            }
            
            var rideValues = ["user": "kreten", "line" : ride.line!, "rating": ride.rating!.description, "points" : pointRecords ]
            rideRef.setValue(rideValues)
        } else {
        
            var rideValues = ["user": "kreten", "line" : ride.line!, "rating": ride.rating!.description]
            rideRef.setValue(rideValues)
        }
    }
    
    
    //MARK: - Fetch Results Controller
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Ride", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "line", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let teamPredicate = NSPredicate(format: "synced == %@", NSNumber(bool: false))
        fetchRequest.predicate = teamPredicate
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController? = nil
}


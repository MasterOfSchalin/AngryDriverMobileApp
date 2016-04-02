//
//  RateMeasurementViewController.swift
//  AngryDriver
//
//  Created by David Prochazka on 01/04/16.
//  Copyright © 2016 David Prochazka. All rights reserved.
//

import UIKit
import CoreData

class RateMeasurementViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    // ride points measured in previous view
    var measuredPoints:[TmpPoint]? = nil
    var managedObjectContext:NSManagedObjectContext? = nil
    
    
    @IBOutlet weak var lineTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // init MOC
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func save(sender: AnyObject) {
        
        guard let lineName = lineTextField.text else {
            lineTextField.becomeFirstResponder()
            return
        }
        
        guard let rating = ratingTextField.text else {
            lineTextField.becomeFirstResponder()
            return
        }
        
        saveNewRide(lineName, rating: Int(rating)!, points: measuredPoints!)
        
        
        goToMainView()
    }
    
    func goToMainView(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        goToMainView()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - CoreData
    
    func saveNewRide(line: String, rating: Int, points: [TmpPoint]){

        let newRide = Ride.createRide(line, rating: rating)
        
        for point in points{
            // save only in case the point contains reasonable data
            if ((point.accX) != nil){
                let newPoint = Point.createPoint(point)
                newPoint.ride = newRide
            }
        }
        
        // Save the context.
        do {
            try self.managedObjectContext!.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            // print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }

}

//
//  MeasurementViewController.swift
//  AngryDriver
//
//  Created by David Prochazka on 01/04/16.
//  Copyright © 2016 David Prochazka. All rights reserved.
//

import UIKit
import CoreMotion

class MeasurementViewController: UIViewController {

    @IBOutlet weak var actualXAcceleration: UILabel!
    @IBOutlet weak var actualYAcceleration: UILabel!
    @IBOutlet weak var actualZAcceleration: UILabel!
    
    @IBOutlet weak var maximalXAcceleration: UILabel!
    @IBOutlet weak var maximalYAcceleration: UILabel!
    @IBOutlet weak var maximalZAcceleration: UILabel!

    var maxXAcceleration: Double = 0.0
    var maxYAcceleration: Double = 0.0
    var maxZAcceleration: Double = 0.0
    
    var actualisationTimer: NSTimer? = nil
    
    @IBOutlet weak var startButton: UIButton!
    
    func initNumbers(){
        actualXAcceleration.text = "0"
        actualYAcceleration.text = "0"
        actualZAcceleration.text = "0"

        maximalXAcceleration.text = "0"
        maximalYAcceleration.text = "0"
        maximalZAcceleration.text = "0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNumbers()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Measurement

    func update(){
        let motion:CMDeviceMotion? = MotionManagerSingleton.getMotionVector()
        
        if let xAcc = motion?.userAcceleration.x{
            actualXAcceleration.text = (round(xAcc*1000)/1000).description
            if (abs(xAcc) > abs(maxXAcceleration)){
                maxXAcceleration = xAcc
                maximalXAcceleration.text = (round(maxXAcceleration*1000)/1000).description
            }
        } else {
            actualXAcceleration.text = "0"
        }
        
        if let yAcc = motion?.userAcceleration.y{
            actualYAcceleration.text = (round(yAcc*1000)/1000).description
            if (abs(yAcc) > abs(maxYAcceleration)){
                maxYAcceleration = yAcc
                maximalYAcceleration.text = (round(maxYAcceleration*1000)/1000).description
            }
        } else {
            actualYAcceleration.text = "0"
        }

        if let zAcc = motion?.userAcceleration.z{
            actualZAcceleration.text = (round(zAcc*1000)/1000).description
            if (abs(zAcc) > abs(maxZAcceleration)){
                maxZAcceleration = zAcc
                maximalZAcceleration.text = (round(maxZAcceleration*1000)/1000).description
            }
        } else {
            actualZAcceleration.text = "0"
        }

        print("X: \(motion?.userAcceleration.x) Y: \(motion?.userAcceleration.y) Z: \(motion?.userAcceleration.z)")
    }
    
    @IBAction func start(sender: AnyObject) {
        if (startButton.currentTitle == "Start"){
        
            actualisationTimer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "update", userInfo: nil, repeats: true)

            startButton.setTitle("Stop", forState: .Normal)
        } else if (startButton.currentTitle == "Stop") {
            actualisationTimer?.invalidate()
            startButton.setTitle("Rate", forState: .Normal)
        } else if (startButton.currentTitle == "Rate") {
            performSegueWithIdentifier("rateRide", sender: nil)
        }
    }
}

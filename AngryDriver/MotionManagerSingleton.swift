//
//  MotionManagerSingleton.swift
//  AngryDriver
//
//  Created by David Prochazka on 01/04/16.
//  Copyright © 2016 David Prochazka. All rights reserved.
//

import UIKit
import CoreMotion


class MotionManagerSingleton: NSObject {
    var motionManager: CMMotionManager
    var referenceAttitude:CMAttitude?=nil
    var bActive = false
    var lastVector:[Float] = [0.0, 0.0, 0.0]
    
    static let cLowPassFactor: Float = 0.95

    
    override init()  {
        motionManager=CMMotionManager()
        motionManager.deviceMotionUpdateInterval = 0.25
        motionManager.startDeviceMotionUpdates()
        bActive=true;
    }
    
    // only one instance of CMMotionManager can be used in your project.
    // => Implement as Singleton which can be used in the whole application
    class var sharedInstance: MotionManagerSingleton {
        struct Singleton {
            static let instance = MotionManagerSingleton()
        }
        return Singleton.instance
    }
    
    class func getMotionManager()->CMMotionManager {
        if (sharedInstance.bActive==false) {
            sharedInstance.motionManager.startDeviceMotionUpdates()
            sharedInstance.bActive=true;
            
        }
        return sharedInstance.motionManager
    }
    
    
    class func getMotionVector() -> CMDeviceMotion? {
        let motion: CMDeviceMotion? = getMotionManager().deviceMotion
        return motion
    }

    
    // Returns an array with the movements
    // At the first time a reference orientation is saved to ensure the motion detection works
    // for multiple device positions
    class func getMotionVectorWithLowPass() -> [Float] {
        // Motion
        let attitude: CMAttitude? = getMotionManager().deviceMotion?.attitude
        
        if sharedInstance.referenceAttitude==nil {
            // Cache Start Orientation to calibrate the device. Wait for a short time to give MotionManager enough time to initialize
            dispatch_after(250, dispatch_get_main_queue(), {
                MotionManagerSingleton.calibrate()
            })
        } else if attitude != nil {
            // Use start orientation to calibrate
            attitude!.multiplyByInverseOfAttitude(sharedInstance.referenceAttitude!)
        }
        
        if attitude != nil {
            return lowPassWithVector([Float(attitude!.yaw), Float(attitude!.roll), Float(attitude!.pitch)])
        } else {
            return [0.0, 0.0, 0.0]
        }
    }
    
    // Stop collection motion data to save energy
    class func stop() {
        sharedInstance.motionManager.stopDeviceMotionUpdates()
        sharedInstance.referenceAttitude=nil
        sharedInstance.bActive=false
    }
    
    // Calibrate motion manager with a ne reference attitude
    class func calibrate() {
        sharedInstance.referenceAttitude = getMotionManager().deviceMotion?.attitude.copy() as? CMAttitude
    }
    
    
    // Damp the jitter caused by hand movement
    class func lowPassWithVector(var vector: [Float]) -> [Float]
    {
        vector[0] = vector[0] * cLowPassFactor + sharedInstance.lastVector[0] * (1.0 - cLowPassFactor)
        vector[1] = vector[1] * cLowPassFactor + sharedInstance.lastVector[1] * (1.0 - cLowPassFactor)
        vector[2] = vector[2] * cLowPassFactor + sharedInstance.lastVector[2] * (1.0 - cLowPassFactor)
        
        sharedInstance.lastVector = vector
        return sharedInstance.lastVector
    }
}

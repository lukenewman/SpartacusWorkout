//
//  MainMenuViewController.swift
//  SpartacusWorkout
//
//  Created by Luke Newman on 2/9/16.
//  Copyright © 2016 Luke Newman. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var beginnerButton: UIButton!
    @IBOutlet weak var regularButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().idleTimerDisabled = false
        
        beginnerButton.layer.cornerRadius = beginnerButton.bounds.height / 2.0
        regularButton.layer.cornerRadius = regularButton.bounds.height / 2.0
        aboutButton.layer.cornerRadius = aboutButton.bounds.height / 2.0
        
        WorkoutSession.currentWorkoutSession.prepareWorkouts()
    }
    
    @IBAction func beginnerTapped(sender: AnyObject) {
        WorkoutSession.currentWorkoutSession.setupForBeginner()
        performSegueWithIdentifier("toWorkout", sender: self)
    }
    
    @IBAction func regularTapped(sender: AnyObject) {
        WorkoutSession.currentWorkoutSession.setupForRegular()
        performSegueWithIdentifier("toWorkout", sender: self)
    }
}

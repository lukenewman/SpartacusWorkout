//
//  WorkoutSessionViewController.swift
//  SpartacusWorkout
//
//  Created by Luke Newman on 2/9/16.
//  Copyright © 2016 Luke Newman. All rights reserved.
//

import UIKit
//import ChameleonFramework

class WorkoutSessionViewController: UIViewController {

    @IBOutlet var workoutTitleLabel: UILabel!
    @IBOutlet var nextUpLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet var pausedView: UIView!
    
    var timer: NSTimer!
    var secondsLeft: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().idleTimerDisabled = true

        secondsLeft = WorkoutSession.currentWorkoutSession.workoutIntervalTime
        
        pauseButton.layer.cornerRadius = pauseButton.bounds.height / 2.0
        pauseButton.layer.borderColor = UIColor.whiteColor().CGColor
        pauseButton.layer.borderWidth = 2.0
        
        setupNextWorkout()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        createTimer()
    }
    
    func createTimer() {
        timer = NSTimer(timeInterval: 1.0, target: self, selector: #selector(subtractTime), userInfo: nil, repeats: true)
        
        let runLoop = NSRunLoop.currentRunLoop()
        runLoop.addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    var paused = false
    
    @IBAction func pause(sender: UIButton) {
        paused = !paused
        sender.setTitle(paused ? "Resume" : "Pause", forState: .Normal)
        
        if paused {
            timer.invalidate()
            
            UIView.animateWithDuration(0.5, animations: { 
                self.pausedView.hidden = false
                self.view.bringSubviewToFront(self.pauseButton)
            })
        } else {
            self.pausedView.hidden = true
            createTimer()
        }
    }
    
    func setupNextWorkout() {
        let workout = WorkoutSession.currentWorkoutSession.getNextWorkout()
        let nextUp = WorkoutSession.currentWorkoutSession.peekNextWorkout()
        
        if let rest = workout as? Rest {
            setupUIForRest(rest)
        } else if let workout = workout {
            setupUIForWorkout(workout)
        } else {
            setupUIForDone()
        }
        
        nextUpLabel.text = nextUp == nil ? "" : "Next Up: \(nextUp!.title)"
    }
    
    func setupUIForWorkout(workout: Workout) {
        secondsLeft = WorkoutSession.currentWorkoutSession.workoutIntervalTime
        workoutTitleLabel.text = workout.title
    }
    
    func setupUIForRest(rest: Rest) {
        secondsLeft = 15
        workoutTitleLabel.text = rest.title
    }
    
    func setupUIForDone() {
        workoutTitleLabel.text = "D O N E"
        timerLabel.text = ""
    }
    
    func subtractTime() {
        secondsLeft -= 1
        
        if secondsLeft == 0 {
            if let _ = WorkoutSession.currentWorkoutSession.peekNextWorkout() as? Rest {
                timerLabel.text = "15"
            } else {
                timerLabel.text = "\(WorkoutSession.currentWorkoutSession.workoutIntervalTime)"
            }
            
            if WorkoutSession.currentWorkoutSession.peekNextWorkout() == nil {
                dismissViewControllerAnimated(true, completion: nil)
            } else {
                setupNextWorkout()
            }
        } else {
            timerLabel.text = "\(secondsLeft)"
        }
    }
}

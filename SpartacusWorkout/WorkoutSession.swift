//
//  WorkoutSession.swift
//  SpartacusWorkout
//
//  Created by Luke Newman on 2/9/16.
//  Copyright © 2016 Luke Newman. All rights reserved.
//

import Foundation

class WorkoutSession {
    
    static let currentWorkoutSession = WorkoutSession()
    
    var workoutIntervalTime = 0
    
    func setupForBeginner() {
        workoutIntervalTime = 30
    }
    
    func setupForRegular() {
        workoutIntervalTime = 60
    }
    
    var workouts: [Workout]!
    
    func prepareWorkouts() {
        workouts = [GobletSquat(), Rest(), MountainClimber(), Rest(), DumbbellSwing(), Rest(), TPushup(), Rest(), SplitJump(), Rest(), DumbbellRow(), Rest(), Abs(), Rest(), PushupRow(), Rest(), DumbbellLungeTwist(), Rest(), ShoulderPress()]
    }
    
    func getNextWorkout() -> Workout? {
        return workouts.removeAtIndex(0)
    }
    
    func peekNextWorkout() -> Workout? {
        if workouts.count > 0 {
            return workouts[0]
        } else {
            return nil
        }
    }
}

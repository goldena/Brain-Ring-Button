//
//  ViewController.swift
//  Brain Ring Button
//
//  Created by Denis Goloborodko on 8.04.21.
//

import UIKit

class PlayerViewController: UIViewController {

    // MARK: - Property(s)
    
    let countdownTimeLimit: Float = 10.0
    var remainingTime: Float!
    
    var remainingTimeToString: String {
        String(Int(remainingTime))
    }
    
    var countdownTimer = Timer()
    
    // MARK: - Outlet(s)
        
    @IBOutlet weak var circularTimerView: CircularCountdownTimer!
    @IBOutlet weak var stopButton: StopButton!
        
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetTimer()
    }
    
    // MARK: - Method(s)
    
    @objc func timerUpdated() {
        guard remainingTime > 0 else {
            stopTimer()
            stopButton.isEnabled = false
            stopButton.setTitle(String("Time is up!"), for: .normal)
            
            return
        }
        
        remainingTime -= 1
        
        circularTimerView.proportionOfCircle = CGFloat(remainingTime / countdownTimeLimit)
        stopButton.setTitle(remainingTimeToString, for: .normal)
    }
    
    func resumeTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdated), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        countdownTimer.invalidate()
    }
    
    func resetTimer() {
        stopTimer()
                        
        remainingTime = countdownTimeLimit
        stopButton.setTitle(remainingTimeToString, for: .normal)
        circularTimerView.proportionOfCircle = 1.0
        
        resumeTimer()
        
        stopButton.isEnabled = true
    }
    
    // MARK: - Action(s)
    
    @IBAction func stopButtonPressed(_ sender: StopButton) {
        sender.isEnabled = false
        
        stopTimer()
    }
    
    @IBAction func stopResetButtonPressed(_ sender: UIButton) {
        resetTimer()
    }
}

// MARK: - Extension(s) - UIViewController



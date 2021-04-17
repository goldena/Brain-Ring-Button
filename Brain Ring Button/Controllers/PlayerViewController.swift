//
//  ViewController.swift
//  Brain Ring Button
//
//  Created by Denis Goloborodko on 8.04.21.
//

import UIKit

class PlayerViewController: UIViewController {

    // MARK: - Property(s)
    
    let countdownTimeLimit = 10
    var remainingTime: Int!
    
    var countdownTimer = Timer()
    
    // MARK: - Outlet(s)
        
    @IBOutlet weak var stopButton: StopButton!
        
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remainingTime = countdownTimeLimit
        stopButton.setTitle(String(remainingTime), for: .normal)
        
        resumeTimer()
    }
    
    // MARK: - Method(s)
    
    @objc func timerUpdated() {
        guard remainingTime > 0 else {
            stopTimer()
            stopButton.isEnabled = false
            
            return
        }

        remainingTime -= 1
        stopButton.setTitle(String(remainingTime), for: .normal)
    }
    
    func resumeTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdated), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        countdownTimer.invalidate()
    }
    
    // MARK: - Action(s)
    
    @IBAction func stopButtonPressed(_ sender: StopButton) {
        sender.isEnabled = false
        
        stopTimer()
        
        stopButton.setTitle(String(remainingTime), for: .normal)
    }
    
    @IBAction func stopResetButtonPressed(_ sender: UIButton) {
        stopTimer()
        
        remainingTime = countdownTimeLimit
        resumeTimer()
        
        stopButton.isEnabled = true
    }
}

// MARK: - Extension(s) - UIViewController



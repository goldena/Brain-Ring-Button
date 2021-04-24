//
//  GameMasterViewController.swift
//  Brain Ring Button
//
//  Created by Denis Goloborodko on 24.04.21.
//

import UIKit

class GameMasterViewController: UIViewController {

    // MARK: - Property(s)
    
    private var stopButton: RoundButtonWithShadow!
    private var yesButton: RoundButtonWithShadow!
    private var noButton: RoundButtonWithShadow!
    
    private let countdownTimeLimit: Float = 60.0
    private var remainingTime: Float!
    
    private var remainingTimeToString: String {
        String(Int(remainingTime))
    }
    
    var countdownTimer = Timer()
    
    // MARK: - Outlet(s)
        
    @IBOutlet weak var circularTimerView: CircularCountdownTimer!
        
    @IBOutlet weak var yesButtonView: UIView!
    
    @IBOutlet weak var noButtonView: UIView!
    
    @IBOutlet weak var playersStackView: UIStackView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton = RoundButtonWithShadow(frame: .zero)
        yesButton = RoundButtonWithShadow(frame: .zero)
        noButton = RoundButtonWithShadow(frame: .zero)
        
        configButton(stopButton, addToView: circularTimerView)
        configButton(yesButton, addToView: yesButtonView)
        configButton(noButton, addToView: noButtonView)
        
        stopButton.addTarget(self, action: #selector(stopButtonPressed(_:)), for: .touchUpInside)
        
        resetTimer()
    }
    
    private func configButton(_ button: RoundButtonWithShadow, addToView: UIView) {
        // button = RoundButtonWithShadow(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false

        addToView.addSubview(button)

        button.centerYAnchor.constraint(equalTo: addToView.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: addToView.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
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
    
    @objc func stopButtonPressed(_ sender: RoundButtonWithShadow) {
        sender.isEnabled = false
        
        stopTimer()
    }
    
    @IBAction func stopResetButtonPressed(_ sender: UIButton) {
        resetTimer()
    }

}

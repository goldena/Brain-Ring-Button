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
    private var yesButton:  RoundButtonWithShadow!
    private var noButton:   RoundButtonWithShadow!
    
    private let countdownTimeLimit: Float = 60.0
    private var remainingTime: Float!
    
    private var remainingTimeToString: String {
        String(Int(remainingTime))
    }
    
    var countdownTimer = Timer()
    
    // MARK: - Outlet(s)
        
    @IBOutlet weak var circularTimerView: CircularCountdownTimer!
        
    @IBOutlet weak var aboveYesButtonView: UIView!
    @IBOutlet weak var yesButtonView: UIView!
    @IBOutlet weak var aboveNoButtonView: UIView!
    @IBOutlet weak var noButtonView: UIView!
    
    @IBOutlet weak var playersStackView: UIStackView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton = RoundButtonWithShadow(frame: .zero)
        yesButton = RoundButtonWithShadow(frame: .zero)
        noButton = RoundButtonWithShadow(frame: .zero)
        
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        noButton.translatesAutoresizingMaskIntoConstraints = false
        
        yesButton.setTitle("YES", for: .normal)
        noButton.setTitle("NO", for: .normal)
        
        stopButton.addTarget(self, action: #selector(stopButtonPressed(_:)), for: .touchUpInside)
        yesButton.addTarget(self, action: #selector(yesButtonPressed(_:)), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(noButtonPressed(_:)), for: .touchUpInside)
        
        addButtons(stopButton, nil, toView: circularTimerView)
        
        resetTimer()
    }
    
    private func addButtons(_ button1: RoundButtonWithShadow, _ button2: RoundButtonWithShadow?, toView: UIView) {
        if button1.superview != nil { button1.removeFromSuperview() }
        
        toView.addSubview(button1)
        
        button1.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
        button1.widthAnchor.constraint(equalTo: button1.heightAnchor).isActive = true
        
        // If the second button is not nil layout both with offset from the center
        if let button2 = button2 {
            if button2.superview != nil { button2.removeFromSuperview() }

            toView.addSubview(button2)

            button2.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
            button2.widthAnchor.constraint(equalTo: button1.heightAnchor).isActive = true

            let offset = min(view.frame.width, view.frame.height) / 4
            
            button1.centerXAnchor.constraint(equalTo: toView.centerXAnchor, constant: -offset).isActive = true
            button2.centerXAnchor.constraint(equalTo: toView.centerXAnchor, constant: +offset).isActive = true
        } else {
            button1.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
        }
    }
    
    func layoutButtons(for size: CGSize) {
        if isPortraitOrientation(for: size) {
            yesButtonView.isHidden = true
            aboveNoButtonView.isHidden = true
            aboveYesButtonView.isHidden = true

            addButtons(yesButton, noButton, toView: noButtonView)
        } else {
            yesButtonView.isHidden = false
            aboveNoButtonView.isHidden = false
            aboveYesButtonView.isHidden = false

            addButtons(noButton, nil, toView: noButtonView)
            addButtons(yesButton, nil, toView: yesButtonView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layoutButtons(for: view.frame.size)
    }
        
    #warning("Move somewhere else")
    func isPortraitOrientation(for size: CGSize) -> Bool {
        size.height > size.width ? true : false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
                
        layoutButtons(for: size)
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
        
        stopButton.isEnabled = true
    }
    
    func stopTimer() {
        countdownTimer.invalidate()
    }
    
    func resetTimer() {
        stopTimer()
                   
        yesButton.isEnabled = false
        noButton.isEnabled = false
        
        remainingTime = countdownTimeLimit
        stopButton.setTitle(remainingTimeToString, for: .normal)
        circularTimerView.proportionOfCircle = 1.0
        
        resumeTimer()
    }
    
    // MARK: - Action(s)
    
    @objc func stopButtonPressed(_ sender: RoundButtonWithShadow) {
        sender.isEnabled = false
        
        stopTimer()
        
        yesButton.isEnabled = true
        noButton.isEnabled = true
    }
    
    @objc func yesButtonPressed(_ sender: RoundButtonWithShadow) {
        yesButton.isEnabled = false
        noButton.isEnabled = false
        
        resumeTimer()
    }
    
    @objc func noButtonPressed(_ sender: RoundButtonWithShadow) {
        yesButton.isEnabled = false
        noButton.isEnabled = false
        
        resumeTimer()
    }
    
    @IBAction func stopResetButtonPressed(_ sender: UIButton) {
        yesButton.isEnabled = false
        noButton.isEnabled = false
        
        resetTimer()
    }
}

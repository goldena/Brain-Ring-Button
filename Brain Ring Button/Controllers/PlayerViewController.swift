//
//  ViewController.swift
//  Brain Ring Button
//
//  Created by Denis Goloborodko on 8.04.21.
//

import UIKit

class PlayerViewController: UIViewController {

    // MARK: - Outlet(s)
        
    @IBOutlet weak var stopButton: StopButton!
        
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.cornerRadius = stopButton.bounds.height / 2
    }

    // MARK: - Action(s)

    func makeCABasicAnimation(keyPath: String, fromValue: Any?, toValue: Any?, duration: CFTimeInterval) -> CABasicAnimation {
        let basicAnimation = CABasicAnimation(keyPath: keyPath)
        
        basicAnimation.fromValue = fromValue
        basicAnimation.toValue = toValue
        basicAnimation.duration = duration
        
        return basicAnimation
    }
    
    @IBAction func stopButtonPressed(_ sender: StopButton) {
    
        #warning("Start here")
        
        DispatchQueue.main.async {
            self.stopButton.layer.add(self.makeCABasicAnimation(keyPath: "cornerRadius", fromValue: 0.0, toValue: 50.0, duration: 1), forKey: "cornerRadius")
        }
        
        let buttonPressAnimation = UIViewPropertyAnimator(
            duration: 1,
            curve: .easeOut
        ) {
             sender.shadowOffset = CGSize(width: 0.0, height: 0.0)
             sender.shadowRadius = 0
//            sender.cornerRadius = 0
        }
                
        buttonPressAnimation.addCompletion { (_) in
            let reversedButtonPressAnimation = UIViewPropertyAnimator(
                duration: 1,
                curve: .easeOut
            ) {
                // sender.cornerRadius = 50
                sender.shadowOffset = CGSize(width: 10.0, height: 10.0)
                sender.shadowRadius = 10
            }
                        
            reversedButtonPressAnimation.startAnimation()
        }

        buttonPressAnimation.startAnimation()
    }
}

// MARK: - Extension(s) - UIViewController



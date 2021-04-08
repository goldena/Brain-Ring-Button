//
//  ViewController.swift
//  Brain Ring Button
//
//  Created by Denis Goloborodko on 8.04.21.
//

import UIKit

class PlayerViewController: UIViewController {

    // MARK: - Outlet(s)
    
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeRounded(stopButton, withRadius: stopButton.bounds.size.width * 0.50)
        stopButton.clipsToBounds = true
    }

}

// MARK: - Extension(s) - UIViewController

extension UIViewController {
    
    func makeRounded(_ aView: UIView, withRadius: CGFloat) {
        aView.layer.cornerRadius = withRadius
    }
}

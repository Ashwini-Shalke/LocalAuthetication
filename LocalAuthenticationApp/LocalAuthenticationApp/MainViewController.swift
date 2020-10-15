//  ViewController.swift
//  test
//
//  Created by Ashwini Shalke on 28/08/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.

import UIKit
import LocalAuthentication

class MainViewController: UIViewController {
    let blurView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.75)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .systemRed
        
        let pressMeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        pressMeButton.translatesAutoresizingMaskIntoConstraints = false
        pressMeButton.setTitle("Press Me", for: .normal)
        pressMeButton.setTitleColor(.white, for: .normal)
        pressMeButton.layer.cornerRadius = pressMeButton.frame.width/2
        pressMeButton.backgroundColor = .systemPink
        pressMeButton.addTarget(self, action: #selector(handlePressMe), for: .touchUpInside)
        
        let welcomeImageView = UIImageView(image: UIImage(named: "Unlock"))
        welcomeImageView.contentMode = .scaleAspectFit
        welcomeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(welcomeImageView)
        NSLayoutConstraint.activate([
            welcomeImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            welcomeImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            welcomeImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        ])
        
        self.view.addSubview(pressMeButton)
        NSLayoutConstraint.activate([
            pressMeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pressMeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            pressMeButton.widthAnchor.constraint(equalToConstant: 150),
            pressMeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    @objc func handlePressMe() {
        //Instance of LAContext
        let context = LAContext()
        var error: NSError?
        // checking the device has capability to do so.
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        {
            
            // explaining the reason for authentication
            let reason = "Touch ID for appName"
            // system biometric check by calling evaluate policy
        
            // optional
                    view.addSubview(blurView)
                    NSLayoutConstraint.activate([
                        blurView.topAnchor.constraint(equalTo: self.view.topAnchor),
                        blurView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                        blurView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                    ])
                    
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    self?.blurView.removeFromSuperview()
                    if success {
                        // Welcome Screen on successful authentication.
                        let welcomeVC = WelcomeViewController()
                        self?.navigationController?.pushViewController(welcomeVC, animated: true)
                    } else {
                        // Error message for authentication failed
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            //Error message if the device is not configured
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
}




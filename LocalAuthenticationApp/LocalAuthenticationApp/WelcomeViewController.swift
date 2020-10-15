//
//  WelcomeViewController.swift
//  test
//
//  Created by Ashwini shalke on 15/09/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        let welcomeImageView = UIImageView(image: UIImage(named: "Welcome"))
        welcomeImageView.contentMode = .scaleAspectFit
        welcomeImageView.translatesAutoresizingMaskIntoConstraints = false
    
        self.view.addSubview(welcomeImageView)
        NSLayoutConstraint.activate([
            welcomeImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            welcomeImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            welcomeImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        ])
    }
    
}

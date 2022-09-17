//
//  ViewController.swift
//  PillBuddy
//
//  Created by Adin Joyce on 9/13/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.backgroundColor = K.Colors.blueColor
        
        view.addSubview(roundedFrame)
        view.addSubview(clearBottleImageView)
        view.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            roundedFrame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            roundedFrame.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            roundedFrame.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            roundedFrame.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            clearBottleImageView.topAnchor.constraint(equalTo: roundedFrame.topAnchor, constant: 110),
            clearBottleImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            emptyLabel.topAnchor.constraint(equalTo: clearBottleImageView.bottomAnchor, constant: 20),
            emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private lazy var roundedFrame: UIView = {
        let frame = UIView()
        frame.translatesAutoresizingMaskIntoConstraints = false // necessary for programatic constraints
        
        frame.backgroundColor = .clear
        frame.layer.cornerRadius = 15
        frame.layer.borderWidth = 5
        frame.layer.borderColor = K.Colors.whiteColor.cgColor
        
        return frame
    }() // on first access of `roundedFrame`, this block will be executed to init roundedFrame
    
    private lazy var clearBottleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        imageView.image = K.Images.clearBottle
        
        return imageView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "You currently do not have any medications listed"
        label.numberOfLines = 0
        label.font = UIFont(name: "Averia Libre", size: 18)
        label.textAlignment = .center
        label.textColor = K.Colors.whiteColor
        
        label.widthAnchor.constraint(equalToConstant: 210).isActive = true
        
        return label
    }()
}


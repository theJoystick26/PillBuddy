//
//  AddViewController.swift
//  PillBuddy
//
//  Created by Adin Joyce on 10/6/22.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.Colors.blueColor
        
        nameTextField.delegate = self
        perDayTextField.delegate = self
        totalPillsTextField.delegate = self

        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(roundedFrame)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(perDayLabel)
        view.addSubview(perDayTextField)
        view.addSubview(totalPillsLabel)
        view.addSubview(totalPillsTextField)
        
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.distribution = .equalSpacing
        nameStackView.axis = .vertical
        nameStackView.spacing = 5
        view.addSubview(nameStackView)
        
        let perDayStackView = UIStackView(arrangedSubviews: [perDayLabel, perDayTextField])
        perDayStackView.translatesAutoresizingMaskIntoConstraints = false
        perDayStackView.distribution = .equalSpacing
        perDayStackView.axis = .vertical
        perDayStackView.spacing = 5
        view.addSubview(perDayStackView)

        let totalPillsStackView = UIStackView(arrangedSubviews: [totalPillsLabel, totalPillsTextField])
        totalPillsStackView.translatesAutoresizingMaskIntoConstraints = false
        totalPillsStackView.distribution = .equalSpacing
        totalPillsStackView.axis = .vertical
        totalPillsStackView.spacing = 5
        view.addSubview(totalPillsStackView)

        let stackView = UIStackView(arrangedSubviews: [nameStackView, perDayStackView, totalPillsStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        

        NSLayoutConstraint.activate([
            roundedFrame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            roundedFrame.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            roundedFrame.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            roundedFrame.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            
            stackView.topAnchor.constraint(equalTo: roundedFrame.topAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: roundedFrame.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: roundedFrame.trailingAnchor, constant: -30)
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
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Name"
        label.numberOfLines = 0
        label.font = UIFont(name: "Averia Libre", size: 18)
        label.textAlignment = .left
        label.textColor = K.Colors.whiteColor
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 275, height: 35))
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.backgroundColor = K.Colors.whiteColor
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var perDayLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Pills per day"
        label.numberOfLines = 0
        label.font = UIFont(name: "Averia Libre", size: 18)
        label.textAlignment = .left
        label.textColor = K.Colors.whiteColor
        
        return label
    }()
    
    private lazy var perDayTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 275, height: 35))
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.backgroundColor = K.Colors.whiteColor
        textField.borderStyle = .roundedRect

        return textField
    }()

    private lazy var totalPillsLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Total pills"
        label.numberOfLines = 0
        label.font = UIFont(name: "Averia Libre", size: 18)
        label.textAlignment = .left
        label.textColor = K.Colors.whiteColor

        return label
    }()
    
    private lazy var totalPillsTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 275, height: 35))
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.backgroundColor = K.Colors.whiteColor
        textField.borderStyle = .roundedRect

        return textField
    }()
    
}

// MARK: - TextField Delegate Methods

extension AddViewController: UITextFieldDelegate {
}

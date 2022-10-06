//
//  ListViewController.swift
//  PillBuddy
//
//  Created by Adin Joyce on 9/13/22.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    private let tableView = UITableView()
    
    // getting the view context from the AppDelegate's persistent container (Core Data Store)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var medications: [Medication]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupTableView()
        setupSubviews()
        
        // Get medications from Core Data
        fetchMedications()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MedicationTableViewCell.self, forCellReuseIdentifier: "MedicationCell")
        tableView.backgroundColor = .clear
        tableView.rowHeight = 138
    }
    
    private func setupSubviews() {
        view.backgroundColor = K.Colors.blueColor
        
        view.addSubview(roundedFrame)
        view.addSubview(clearBottle)
        view.addSubview(emptyLabel)
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            roundedFrame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            roundedFrame.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            roundedFrame.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            roundedFrame.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            clearBottle.topAnchor.constraint(equalTo: roundedFrame.topAnchor, constant: 110),
            clearBottle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            emptyLabel.topAnchor.constraint(equalTo: clearBottle.bottomAnchor, constant: 20),
            emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: 65),
            addButton.heightAnchor.constraint(equalToConstant: 65),
            addButton.bottomAnchor.constraint(equalTo: roundedFrame.bottomAnchor, constant: -20),
            addButton.trailingAnchor.constraint(equalTo: roundedFrame.trailingAnchor, constant: -15),

            tableView.topAnchor.constraint(equalTo: roundedFrame.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: roundedFrame.leadingAnchor, constant: 10),
            tableView.bottomAnchor.constraint(greaterThanOrEqualTo: roundedFrame.bottomAnchor, constant: -10),
            tableView.trailingAnchor.constraint(equalTo: roundedFrame.trailingAnchor, constant: -10)
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
    
    private lazy var clearBottle: UIImageView = {
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
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.frame = CGRect(x: 0, y: 0, width: 65, height: 65)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        // scales image size
        button.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        
        button.backgroundColor = K.Colors.whiteColor
        button.tintColor = K.Colors.blueColor
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return button
    }()
}

// MARK: - Button Methods

extension ListViewController {
    @objc func buttonPressed(sender: UIButton!) {
        let addVC = AddViewController()
        addVC.modalPresentationStyle = .fullScreen
        self.present(addVC, animated: true, completion: nil)
    }
}

// MARK: - TableView Methods

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (medications?.count != 0) {
            clearBottle.isHidden = true
            emptyLabel.isHidden = true
        }
        
        return medications?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath) as! MedicationTableViewCell
        cell.medication = medications?[indexPath.row]
        return cell
    }
}

// Core Data Methods

extension ListViewController {
    func fetchMedications() {
        do {
            self.medications = try context.fetch(Medication.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
        }
    }
}


//
//  ViewController.swift
//  PillBuddy
//
//  Created by Adin Joyce on 9/13/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
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
        
        NSLayoutConstraint.activate([
            roundedFrame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            roundedFrame.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            roundedFrame.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            roundedFrame.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            clearBottle.topAnchor.constraint(equalTo: roundedFrame.topAnchor, constant: 110),
            clearBottle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            emptyLabel.topAnchor.constraint(equalTo: clearBottle.bottomAnchor, constant: 20),
            emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
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
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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

extension ViewController {
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


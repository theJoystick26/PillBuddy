//
//  MedicationTableViewCell.swift
//  PillBuddy
//
//  Created by Adin Joyce on 10/1/22.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {
    var medication: Medication? {
        didSet {
            medicineLabel.text = "\(medication?.name ?? "") \(medication?.dosage ?? 0) mg"
            daysLeftLabel.text = "Days left: \(medication?.daysLeft ?? 0)"
        }
    }
    
    private lazy var cellView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.cornerRadius = 15
        view.backgroundColor = K.Colors.whiteColor
        
        return view
    }()
    
    private lazy var orangeBottle: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        imageView.image = K.Images.orangeBottle
        
        return imageView
    }()
    
    private lazy var medicineLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont(name: "Averia Libre", size: 18)
        
        return label
    }()
    
    private lazy var daysLeftLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont(name: "Averia Libre", size: 18)
        
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(cellView)
        addSubview(orangeBottle)
        addSubview(medicineLabel)
        addSubview(daysLeftLabel)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            orangeBottle.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 44),
            orangeBottle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            
            medicineLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 45),
            medicineLabel.leadingAnchor.constraint(equalTo: orangeBottle.trailingAnchor, constant: 25),
            
            daysLeftLabel.topAnchor.constraint(equalTo: medicineLabel.bottomAnchor, constant: 5),
            daysLeftLabel.leadingAnchor.constraint(equalTo: orangeBottle.trailingAnchor, constant: 25)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

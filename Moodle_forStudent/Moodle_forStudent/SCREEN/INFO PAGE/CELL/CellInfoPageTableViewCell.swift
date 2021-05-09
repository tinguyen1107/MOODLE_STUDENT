//
//  CellInfoPageTableViewCell.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 24/04/2021.
//

import UIKit

class CellInfoPageTableViewCell: UITableViewCell {
    
    static var enabledToInput = false
    
    var typeID: Int?
    var cellID: IndexPath?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    let inputNormal: BaseInput = {
        let textField = BaseInput()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.placeholder = "nothing"
        textField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.attributedPlaceholder = NSAttributedString(string: "placeholder text", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        return textField
    }()
    
    let inputNumber: BaseInputNumber = {
        let textField = BaseInputNumber()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.placeholder = "nothing"
        textField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.attributedPlaceholder = NSAttributedString(string: "placeholder text", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        return textField
    }()
    
    let inputPickup: BaseInputByPickup = {
        let textField = BaseInputByPickup()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.placeholder = "nothing"
        textField.selections = ["Male", "Female"]
        textField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textField.attributedPlaceholder = NSAttributedString(string: "placeholder text", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        return textField
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView ()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        setupView ()
    }

    private func setupView () {
        self.contentView.addSubview(titleLabel)
        
        inputNormal.delegate = self
        inputNumber.delegate = self
        inputPickup.delegate = self
        
        setupTitleLable()
        
        if (typeID == 0) {
            self.contentView.addSubview(inputNormal)
            setupInputNormal()
        } else if (typeID == 1) {
            self.contentView.addSubview(inputNumber)
            setupInputNumber()
        } else if (typeID == 2) {
            self.contentView.addSubview(inputPickup)
            setupInputPickup()
        }
    }
    
    private func setupTitleLable () {
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor).isActive = true
    }
    
    private func setupInputNormal () {
        inputNormal.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        inputNormal.borderStyle = .none
        inputNormal.isEnabled = CellInfoPageTableViewCell.enabledToInput
        
        if (!CellInfoPageTableViewCell.enabledToInput) {
            inputNormal.placeholder = inputNormal.text
            inputNormal.text = ""
        }
        
        inputNormal.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        inputNormal.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        inputNormal.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5).isActive = true
        inputNormal.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
    }
    
    private func setupInputNumber () {
        inputNumber.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        inputNumber.borderStyle = .none
        inputNumber.isEnabled = CellInfoPageTableViewCell.enabledToInput
        
        if (!CellInfoPageTableViewCell.enabledToInput) {
            inputNumber.placeholder = inputNumber.text
            inputNumber.text = ""
        }
        
        inputNumber.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        inputNumber.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        inputNumber.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5).isActive = true
        inputNumber.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
    }
    
    private func setupInputPickup () {
        inputPickup.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        inputPickup.borderStyle = .none
        inputPickup.isEnabled = CellInfoPageTableViewCell.enabledToInput
        
        if (!CellInfoPageTableViewCell.enabledToInput) {
            inputPickup.placeholder = inputPickup.text
            inputPickup.text = ""
        }
        
        inputPickup.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        inputPickup.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        inputPickup.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5).isActive = true
        inputPickup.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
    }
    
    override func prepareForReuse() {
        inputNormal.placeholder = ""
        inputNumber.placeholder = ""
        inputPickup.placeholder = ""
    }
}

extension CellInfoPageTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        var text = textField.text ?? "nothing"
        if text == "" {
            text = "nothing"
        }
        DefaultData.student.sourceArrayData[cellID!.section][cellID!.row] = text
    }
}

//
//  CellButtonInfoPageTableViewCell.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 26/04/2021.
//

import UIKit



class CellButtonInfoPageTableViewCell: UITableViewCell {
    
    var closure: ((Int) -> Void)?
    var cellID: IndexPath?

    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = loginColor.cgColor
        button.layer.cornerRadius = 7
        button.setTitleColor(loginColor, for: .normal)
        button.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
        return button
    }()

    @objc func didClickButton() {
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = loginColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [self] in
            button.layer.borderColor = loginColor.cgColor
            button.setTitleColor(loginColor, for: .normal)
            button.backgroundColor = .clear
        })
        closure?(cellID!.row)
    }

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
        self.backgroundColor = .clear
        
        self.contentView.addSubview(button)
        button.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
        setupButton()
    }
    
    private func setupButton () {
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2).isActive = true
    }
}

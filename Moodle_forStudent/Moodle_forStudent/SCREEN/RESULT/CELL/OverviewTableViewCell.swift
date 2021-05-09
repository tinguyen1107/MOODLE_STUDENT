//
//  OverviewTableViewCell.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 08/05/2021.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = . left
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView ()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView ()
    }
    
    private func setupView () {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(contentLabel)
        
        setupCourseNameLabel()
        setupCourseNameContentLabel()
    }
    
    private func setupCourseNameLabel () {
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -7).isActive = true
    }
    
    private func setupCourseNameContentLabel() {
        contentLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        contentLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
    }

}

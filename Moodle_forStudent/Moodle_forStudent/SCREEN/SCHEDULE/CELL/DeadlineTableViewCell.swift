//
//  DeadlineTableViewCell.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 08/05/2021.
//

import UIKit

class DeadlineTableViewCell: UITableViewCell {
    
    let courseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let titleDeadlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContentView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupContentView()
    }

    func setupContentView () {
        self.contentView.addSubview(courseNameLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(titleDeadlineLabel)
        self.contentView.addSubview(contentLabel)

        setupCourseNameLabel()
        setupDateLabel()
        setupTitleDeadlineLabel()
        setupContentLabel()
    }
    
    func setupCourseNameLabel() {
        courseNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        courseNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        courseNameLabel.sizeToFit()
    }
    
    func setupDateLabel() {
        dateLabel.sizeToFit()

        dateLabel.centerYAnchor.constraint(equalTo: courseNameLabel.centerYAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: courseNameLabel.heightAnchor).isActive = true
    }
    
    func setupTitleDeadlineLabel() {
        titleDeadlineLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        titleDeadlineLabel.topAnchor.constraint(equalTo: courseNameLabel.topAnchor).isActive = true
        titleDeadlineLabel.heightAnchor.constraint(equalTo: courseNameLabel.heightAnchor).isActive = true
        titleDeadlineLabel.leadingAnchor.constraint(equalTo: courseNameLabel.trailingAnchor, constant: 5).isActive = true
        titleDeadlineLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -5).isActive = true
        
        titleDeadlineLabel.sizeToFit()
    }
    
    func setupContentLabel() {
        contentLabel.sizeToFit()
        
        contentLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        contentLabel.topAnchor.constraint(equalTo: titleDeadlineLabel.bottomAnchor, constant: 5).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        contentLabel.heightAnchor.constraint(greaterThanOrEqualTo: courseNameLabel.heightAnchor).isActive = true
    }
}

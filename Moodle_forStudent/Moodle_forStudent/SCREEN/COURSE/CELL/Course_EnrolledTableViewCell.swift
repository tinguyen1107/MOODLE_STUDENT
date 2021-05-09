//
//  Course_EnrolledTableViewCell.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 04/05/2021.
//

import UIKit

class Course_EnrolledTableViewCell: UITableViewCell {
    
    var status = "0"
    
/// course name label
    private let courseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = . left
        label.text = "Course name: "
        return label
    }()
    
    let courseNameContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "none"
        return label
    }()

/// status of course
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Status: "
        return label
    }()
    
    let statusContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupContentView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupContentView()
        // Configure the view for the selected state
    }

    func setupContentView () {
        self.addSubview(courseNameLabel)
        self.addSubview(courseNameContentLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusContentLabel)
        
        setupCourseNameLabel()
        setupCourseNameContentLabel()
        setupStatusLabel()
        setupStatusContentLabel()
    }
    
    func setupCourseNameLabel() {
        courseNameLabel.sizeToFit()
        
        courseNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        courseNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        courseNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor).isActive = true
    }
    
    func setupCourseNameContentLabel() {
        courseNameContentLabel.centerYAnchor.constraint(equalTo: courseNameLabel.centerYAnchor).isActive = true
        courseNameContentLabel.leadingAnchor.constraint(equalTo: courseNameLabel.trailingAnchor).isActive = true
        courseNameContentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    func setupStatusLabel() {
        statusLabel.sizeToFit()
        
        statusLabel.topAnchor.constraint(equalTo: courseNameLabel.bottomAnchor, constant: 3).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: courseNameLabel.leadingAnchor).isActive = true
        statusLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor).isActive = true
        statusLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
    }
    
    func setupStatusContentLabel() {
        if (status == "0") {
            statusContentLabel.text = "sent"
            statusContentLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else if (status == "1") {
            statusContentLabel.text = "successed"
            statusContentLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else if (status == "2") {
            statusContentLabel.text = "failed"
            statusContentLabel.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        }
        
        statusContentLabel.topAnchor.constraint(equalTo: statusLabel.topAnchor).isActive = true
        statusContentLabel.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor).isActive = true
        statusContentLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor).isActive = true
        statusContentLabel.trailingAnchor.constraint(equalTo: courseNameContentLabel.trailingAnchor).isActive = true
    }
    
}


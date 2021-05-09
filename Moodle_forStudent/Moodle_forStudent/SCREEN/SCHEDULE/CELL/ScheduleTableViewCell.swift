//
//  ScheduleTableViewCell.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 08/05/2021.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let courseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    let roomLabel: UILabel = {
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
    }

    func setupContentView () {
        self.addSubview(dateLabel)
        self.addSubview(courseNameLabel)
        self.addSubview(roomLabel)
        
        setupDateLabel()
        setupCourseNameLabel()
        setupRoomLabel()
    }
    
    func setupDateLabel() {
        dateLabel.sizeToFit()

        dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor).isActive = true
    }
    
    
    func setupCourseNameLabel() {
        
        courseNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        courseNameLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant:  15).isActive = true
        courseNameLabel.trailingAnchor.constraint(equalTo: roomLabel.leadingAnchor, constant: -15).isActive = true
    }
    
    
    func setupRoomLabel() {
//        roomLabel.sizeToFit()
        
        roomLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        roomLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        roomLabel.widthAnchor.constraint(equalTo: dateLabel.widthAnchor, multiplier: 0.3).isActive = true
    }
}


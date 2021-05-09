//
//  Course_ListTableViewCell.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 04/05/2021.
//

import UIKit

class Course_ListTableViewCell: UITableViewCell {
    
///Course name
    private let courseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.textAlignment = .left
        label.sizeToFit()
        label.text = "Course: "
        return label
    }()
    
    let courseNameContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.textAlignment = .right
        label.sizeToFit()
        label.text = "none"
        return label
    }()

///Number of student
    private let numberOfStudentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.textAlignment = .left
        label.sizeToFit()
        label.text = "Number of students: "
        return label
    }()

    let numberOfStudentContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.textAlignment = .right
        label.sizeToFit()
        label.text = "none"
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
        self.contentView.addSubview(courseNameLabel)
        self.contentView.addSubview(courseNameContentLabel)
        self.contentView.addSubview(numberOfStudentLabel)
        self.contentView.addSubview(numberOfStudentContentLabel)
    
        setupCourseNameLabel()
        setupCourseNameContentLabel()
        setupNumberOfStudentLabel()
        setupNumberOfStudentContentLabel()
    }

    private func setupCourseNameLabel () {
        courseNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        courseNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        courseNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor).isActive = true
    }
    
    private func setupCourseNameContentLabel() {
        courseNameContentLabel.centerYAnchor.constraint(equalTo: courseNameLabel.centerYAnchor).isActive = true
        courseNameContentLabel.heightAnchor.constraint(equalTo: courseNameLabel.heightAnchor).isActive = true
        courseNameContentLabel.leadingAnchor.constraint(equalTo: courseNameLabel.trailingAnchor).isActive = true
        courseNameContentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupNumberOfStudentLabel () {
        numberOfStudentLabel.topAnchor.constraint(equalTo: courseNameLabel.bottomAnchor, constant: 3).isActive = true
        numberOfStudentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        numberOfStudentLabel.leadingAnchor.constraint(equalTo: courseNameLabel.leadingAnchor).isActive = true
        numberOfStudentLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor).isActive = true
        numberOfStudentLabel.heightAnchor.constraint(equalTo: courseNameLabel.heightAnchor).isActive = true
    }

    private func setupNumberOfStudentContentLabel() {
        numberOfStudentContentLabel.centerYAnchor.constraint(equalTo: numberOfStudentLabel.centerYAnchor).isActive = true
        numberOfStudentContentLabel.heightAnchor.constraint(equalTo: numberOfStudentContentLabel.heightAnchor).isActive = true
        numberOfStudentContentLabel.leadingAnchor.constraint(equalTo: numberOfStudentLabel.trailingAnchor).isActive = true
        numberOfStudentContentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }

}

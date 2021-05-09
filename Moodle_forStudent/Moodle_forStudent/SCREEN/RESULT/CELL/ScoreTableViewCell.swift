//
//  ScoreTableViewCell.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 08/05/2021.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    let courseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let schoolYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let semesterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreLabel: UILabel = {
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
        self.contentView.addSubview(courseNameLabel)
        self.contentView.addSubview(schoolYearLabel)
        self.contentView.addSubview(semesterLabel)
        self.contentView.addSubview(scoreLabel)
        
        setupCourseNameLabel()
        setupSchoolYear()
        setupSemesterLabel()
        setupScoreLabel()
    }
    
    func setupCourseNameLabel () {
        courseNameLabel.sizeToFit()
        
        courseNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7).isActive = true
        courseNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        courseNameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -7).isActive = true
        courseNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor).isActive = true
    }
    
    func setupSchoolYear() {
        schoolYearLabel.sizeToFit()
        
        schoolYearLabel.topAnchor.constraint(equalTo: courseNameLabel.topAnchor).isActive = true
        schoolYearLabel.leadingAnchor.constraint(equalTo: courseNameLabel.trailingAnchor, constant: 5).isActive = true
        schoolYearLabel.bottomAnchor.constraint(equalTo: courseNameLabel.bottomAnchor).isActive = true
    }
    
    func setupSemesterLabel() {
        semesterLabel.sizeToFit()
        
        semesterLabel.topAnchor.constraint(equalTo: courseNameLabel.topAnchor).isActive = true
        semesterLabel.leadingAnchor.constraint(equalTo: schoolYearLabel.trailingAnchor, constant: 10).isActive = true
        semesterLabel.bottomAnchor.constraint(equalTo: courseNameLabel.bottomAnchor).isActive = true
    }
    
    func setupScoreLabel() {
        scoreLabel.sizeToFit()
        
        scoreLabel.topAnchor.constraint(equalTo: courseNameLabel.topAnchor).isActive = true
        scoreLabel.leadingAnchor.constraint(equalTo: semesterLabel.trailingAnchor, constant: 10).isActive = true
        scoreLabel.bottomAnchor.constraint(equalTo: courseNameLabel.bottomAnchor).isActive = true
        scoreLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        scoreLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.15).isActive = true
    }
    
}

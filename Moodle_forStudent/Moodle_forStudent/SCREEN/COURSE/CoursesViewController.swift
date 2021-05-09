//
//  EnrollCourseViewController.swift
//  Moodle
//
//  Created by Trọng Tín on 12/04/2021.
//

import UIKit

class CoursesViewController: UIViewController {
        
    let CellID_CourseEnrolled = "bakswmn"
    let CellID_CourseList = "nkddhkssaot"
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Courses"
        
        view.backgroundColor = .white
        setupTableView()
        
        DefaultData.course.ditinit (completion: { [self] in
            print ("did load enrolled data")
            tableView.reloadData()
        })
    
        DefaultData.listCanEnrollCourse.ditinit(completion: { [self] in
            print ("get all course can be enrolled")
            tableView.reloadData()
        })
    }
    
    func setupTableView () {
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Course_EnrolledTableViewCell.self, forCellReuseIdentifier: CellID_CourseEnrolled)
        tableView.register(Course_ListTableViewCell.self, forCellReuseIdentifier: CellID_CourseList)
        
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? DefaultData.course.enrolled.count : DefaultData.listCanEnrollCourse.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 53 : 53
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = loginColor
        
        let label = UILabel()
        label.text = section == 0 ? "Registered" : "Course list"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = .clear
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        // add
        header.addSubview(label)
        // position
        label.topAnchor.constraint(equalTo: header.topAnchor, constant: 5).isActive = true
        label.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -5).isActive = true
        label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 5).isActive = true
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = CourseDetailViewController()
        detail.title = indexPath.section == 0 ? DefaultData.course.enrolled[indexPath.row][0] : DefaultData.listCanEnrollCourse.list[indexPath.row].mID
        
        
        
        self.navigationController?.pushViewController(detail, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID_CourseEnrolled, for: indexPath) as! Course_EnrolledTableViewCell
            cell.courseNameContentLabel.text = DefaultData.course.enrolled[indexPath.row][0]
            cell.status = DefaultData.course.enrolled[indexPath.row][1]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID_CourseList, for: indexPath) as! Course_ListTableViewCell
            cell.courseNameContentLabel.text = DefaultData.listCanEnrollCourse.list[indexPath.row].mID
            cell.numberOfStudentContentLabel.text = String(DefaultData.listCanEnrollCourse.list[indexPath.row].Current) + " / " +  String(DefaultData.listCanEnrollCourse.list[indexPath.row].Maximum)
            return cell
        }
    }
    
    
}

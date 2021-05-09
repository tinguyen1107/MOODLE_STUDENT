//
//  ResultEnrollViewController.swift
//  Moodle
//
//  Created by Trọng Tín on 12/04/2021.
//

import UIKit

class ScheduleViewController: UIViewController {

    let Cell_ID = "auysfyagskjskf"
    let Cell_IDDeadline = "aikhdaik,wqg"
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView () {
        self.title = "Schedule"
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        
        setupTableView()
        
        API.course.getCurrentCourse(completion: {
            self.tableView.reloadData()
        })
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: Cell_ID)
        tableView.register(DeadlineTableViewCell.self, forCellReuseIdentifier: Cell_IDDeadline)

        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DefaultData.listOfCurrentCourse.arraySchedule.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == DefaultData.listOfCurrentCourse.arraySchedule.count ? DefaultData.listOfCurrentCourse.arrayDeadline.count : DefaultData.listOfCurrentCourse.arraySchedule[section].count - 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == DefaultData.listOfCurrentCourse.arraySchedule.count ? "Deadline" : DefaultData.listOfCurrentCourse.arraySchedule[section][0][0]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == DefaultData.listOfCurrentCourse.arraySchedule.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell_IDDeadline, for: indexPath) as! DeadlineTableViewCell
            cell.courseNameLabel.text = DefaultData.listOfCurrentCourse.arrayDeadline[indexPath.row][0]
            cell.dateLabel.text = DefaultData.listOfCurrentCourse.arrayDeadline[indexPath.row][1]
            cell.titleDeadlineLabel.text = DefaultData.listOfCurrentCourse.arrayDeadline[indexPath.row][2]
            cell.contentLabel.text = DefaultData.listOfCurrentCourse.arrayDeadline[indexPath.row][3]
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell_ID, for: indexPath) as! ScheduleTableViewCell
        cell.dateLabel.text = DefaultData.listOfCurrentCourse.arraySchedule[indexPath.section][indexPath.row + 1][0]
        cell.courseNameLabel.text = DefaultData.listOfCurrentCourse.arraySchedule[indexPath.section][indexPath.row + 1][1]
        cell.roomLabel.text = DefaultData.listOfCurrentCourse.arraySchedule[indexPath.section][indexPath.row + 1][2]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}

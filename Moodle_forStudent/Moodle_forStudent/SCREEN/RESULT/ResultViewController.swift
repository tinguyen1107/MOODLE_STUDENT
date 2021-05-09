//
//  ResultViewController.swift
//  Moodle
//
//  Created by Trọng Tín on 12/04/2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    let titleForCellOverview = ["Total credits accumulated:", "Total GPA is cumulative:", "Qualifying for graduation:"]
        
    let Cell_ID_OverView = "diuighwifnhweuyckquigqk"
    let Cell_ID_Score = "abc"

    let tableView: UITableView = {
        let table = UITableView()
        table.allowsSelection = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Result"
        
        view.addSubview(tableView)
        
        setupTableView()
        
        API.student.getOverview(completion: {
            self.tableView.reloadData()
        })
        
        API.course.getCourseCompleted(completion: { [self] in
            tableView.reloadData()
        }, thereNoData: {
            print("no data")
        })
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: Cell_ID_Score)
        tableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: Cell_ID_OverView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ?  DefaultData.overview.arr.count : DefaultData.listCourseComplete.list.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Overview" : "Details"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell_ID_OverView, for: indexPath) as! OverviewTableViewCell
            cell.titleLabel.text = titleForCellOverview[indexPath.row]
            cell.contentLabel.text = DefaultData.overview.arr[indexPath.row]
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell_ID_Score, for: indexPath) as! ScoreTableViewCell
        cell.courseNameLabel.text = DefaultData.listCourseComplete.list[indexPath.row].id
        cell.schoolYearLabel.text = DefaultData.listCourseComplete.list[indexPath.row].year
        cell.semesterLabel.text = DefaultData.listCourseComplete.list[indexPath.row].semester
        cell.scoreLabel.text = DefaultData.listCourseComplete.list[indexPath.row].score
        return cell
    }
    
    
}

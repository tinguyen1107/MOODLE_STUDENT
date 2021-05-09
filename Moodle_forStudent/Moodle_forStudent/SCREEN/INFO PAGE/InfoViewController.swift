//
//  InfoViewController.swift
//  Moodle
//
//  Created by Trọng Tín on 30/03/2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    let cellID = "00_01"
    let cellButtonID = "02"
    
    var closure: ((Bool) -> Void)?
    
    let titleForCellSection_0 = ["Student ID", "Last name", "First name", "Gender", "Indentity number", "Email", "Phone"]
    let titleForCellSection_1 = ["Bank", "Bank number", "Branch"]
    var titleForCellSection_2 = ["Edit", "Change password", "Log out"]
    
    let tableView: UITableView = {
        let table = UITableView()
        table.allowsSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.hideKeyboardWhenTappedAround()
        title = "Info"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        setupTableView()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellInfoPageTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(CellButtonInfoPageTableViewCell.self, forCellReuseIdentifier: cellButtonID)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,constant: -4).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? titleForCellSection_0.count : (section == 1) ? titleForCellSection_1.count : titleForCellSection_2.count
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? CellInfoPageTableViewCell().frame.height * 11/10 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellButtonID, for: indexPath) as! CellButtonInfoPageTableViewCell
            cell.button.setTitle(titleForCellSection_2[indexPath.row], for: .normal)
            cell.cellID = indexPath
            cell.closure = { index in
                if index == 0 {
                    if (cell.button.title(for: .normal) == "Edit") { self.titleForCellSection_2[0] = "Done" }
                    else { self.titleForCellSection_2[0] = "Edit" }
                    self.closure?(true)
                    API.student.saveInfoStudent(arrData: DefaultData.student.sourceArrayData, completion: {
                    })
                    tableView.reloadData()
                } else if index == 1 {
                    let alert = UIAlertController(title: "Change password", message: nil, preferredStyle: .alert)
                    alert.addTextField()
                    alert.addTextField()
                    
                    alert.textFields![0].placeholder = "Input old password"
                    alert.textFields![1].placeholder = "Input new password"
                    
                    alert.textFields![0].isSecureTextEntry = true
                    alert.textFields![1].isSecureTextEntry = true
                    
                    alert.addAction(UIAlertAction(title: "Change", style: .default, handler: {_ in
                        let oldPass = alert.textFields![0].text ?? "abcd"
                        let newPass = alert.textFields![1].text ?? "abcd"
                        
                        if oldPass.count < 6 || newPass.count < 6 {
                            let alert = UIAlertController (title: "Error", message: "Password must  be 6 characters or more", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Try again", style: .destructive, handler: { action in
                                print ("try again")
                            }))
                            self.present(alert, animated: true)
                        } else {
                            API.student.changePassword(id: DefaultData.student.mStudentID!, password: alert.textFields![0].text ?? "abc", newPassword: alert.textFields![1].text ?? "abc", ok: {
                                let alert = UIAlertController (title: "Successfully", message: nil, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                                self.present(alert, animated: true)
                            }, kook: {
                                let alert = UIAlertController (title: "Wrong Password", message: nil, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Try again", style: .destructive, handler: nil))
                                self.present(alert, animated: true)
                            })
                        }
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } else if index == 2 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let login = LogInViewController()
                        login.modalPresentationStyle = .fullScreen
                        self.present(login, animated: true, completion: nil)
                    }
                }
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CellInfoPageTableViewCell
        closure = { _ in
            CellInfoPageTableViewCell.enabledToInput = !CellInfoPageTableViewCell.enabledToInput
        }
        ///Type for input text field
        cell.typeID = 0
        if (indexPath.section == 0) {
            if (indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 6) { cell.typeID = 1 }
            else if (indexPath.row == 3) { cell.typeID = 2 }
        } else {
            if (indexPath.row == 1) { cell.typeID = 1 }
        }
        if (cell.typeID == 0) {
//            cell.inputNormal
            cell.inputNormal.text = DefaultData.student.sourceArrayData[indexPath.section][indexPath.row]
        } else if (cell.typeID == 1) {
//            cell.inputNumber
            cell.inputNumber.text = DefaultData.student.sourceArrayData[indexPath.section][indexPath.row]
        } else if (cell.typeID == 2) {
//            cell.inputPickup
            cell.inputPickup.text = DefaultData.student.sourceArrayData[indexPath.section][indexPath.row]
        }
        cell.cellID = indexPath
        cell.backgroundColor = .clear
        cell.titleLabel.text = (indexPath.section == 0) ? titleForCellSection_0[indexPath.row] : titleForCellSection_1[indexPath.row]
        return cell
    }
}

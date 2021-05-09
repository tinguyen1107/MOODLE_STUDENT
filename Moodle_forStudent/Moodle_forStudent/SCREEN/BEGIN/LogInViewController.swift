//
//  LogInViewController.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 23/04/2021.
//

import UIKit

class LogInViewController: UIViewController {

    override open var shouldAutorotate: Bool { /// screen rotate
        return false
    }
    
    var inputContainerHeightAnchor: NSLayoutConstraint?
    var nameUserTextFieldHeightAnchor: NSLayoutConstraint?
    
    let iconForApp: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "person.custom")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let inputContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = loginColor.cgColor
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(loginColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginOrRegister), for: .touchUpInside)
        return button
    }()
    
    @objc func loginOrRegister() {
        
        loginRegisterButton.layer.borderColor = UIColor.white.cgColor
        loginRegisterButton.backgroundColor = loginColor
        loginRegisterButton.setTitleColor(.white, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [self] in
            loginRegisterButton.layer.borderColor = loginColor.cgColor
            loginRegisterButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            loginRegisterButton.setTitleColor(loginColor, for: .normal)
        })
        
        if (loginRegisterSegmentedControl.selectedSegmentIndex == 0) {
            guard let id = idTextField.text, let pass = passwordTextField.text else  {
                print ("error")
                pushUpAlert(title: "Error", message: "Missing input id or password")
                return
            }
            if (id == "" || pass == "") {
                pushUpAlert(title: "Error", message: "Missing input id or password")
                return
            }
            
            API.student.checkExist(id: id, nonExisted: {
                self.pushUpAlert(title: "Error", message: "This ID is not exist")
                return
            }, existed: { print ("existed") })
            
            API.student.getPassword(id: id, completion: { password in
                if (password == pass) { self.createTabViewController(id: id) }
                else { self.pushUpAlert(title: "Error", message: "Wrong id or password") }
            })
        } else {
            guard let name = nameUserTextField.text, let id = idTextField.text, let pass = passwordTextField.text else {
                print ("error")
                pushUpAlert(title: "Error", message: "Missing input id or password")
                return
            }
            if (id == "" || pass == "" || name == "") {
                pushUpAlert(title: "Error", message: "Missing input somethings")
                return
            }
            API.student.createNewAccount(name: name, id: id, pass: pass, completion: { check in
                if check { self.createTabViewController(id: id) }
                else { self.pushUpAlert(title: "Error", message: "This id have existed") }
            })
        }
    }
    
    let nameUserTextField: BaseInput = {
        let textfield = BaseInput()
        textfield.borderStyle = .roundedRect
//        textfield.backgroundColor = UIColor.white
        textfield.placeholder = "User Name"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let idTextField: BaseInputNumber = {
        let textfield = BaseInputNumber()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "ID"
//        textfield.backgroundColor = UIColor.white
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    let passwordTextField: BaseInput = {
        let textfield = BaseInput()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Password"
//        textfield.backgroundColor = UIColor.white
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Login", "Register"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.layer.borderColor = CGColor.init(gray: 1, alpha: 1)
        segmented.layer.borderWidth = 0.5
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return segmented
    }()
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        let which = loginRegisterSegmentedControl.selectedSegmentIndex == 0 //login: true, register: false
        // change height of inputContainer
        inputContainerHeightAnchor?.constant = which ? 100 : 150
        
        // change height of nameUser tf
        nameUserTextFieldHeightAnchor?.constant = which ? 0 : 50
        
        clearAllDidInput()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        clearDefaultData()

        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = loginColor
        
        self.view.addSubview(iconForApp)
        self.view.addSubview(inputContainerView)
        self.view.addSubview(loginRegisterButton)
        self.view.addSubview(loginRegisterSegmentedControl)
        
        setupIconForApp()
        setupInputContainerView()
        setupLoginRegisterButton()
        setupLoginRegisterSegmentedControl()
    }
    
    private func clearDefaultData() {
        DefaultData.listCourseComplete.list.removeAll()
        DefaultData.listOfCurrentCourse.data.removeAll()
        DefaultData.listOfCurrentCourse.arraySchedule.removeAll()
        DefaultData.listOfCurrentCourse.arrayDeadline.removeAll()
    }
    
    private func setupIconForApp() {
        iconForApp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconForApp.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: loginRegisterSegmentedControl.topAnchor, multiplier: 1).isActive = true
        iconForApp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        iconForApp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
    }
    
    private func setupInputContainerView() {
        // x, y, width, heigh
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        inputContainerHeightAnchor = inputContainerView.heightAnchor.constraint(equalToConstant: 100)
        inputContainerHeightAnchor?.isActive = true
        
        inputContainerView.addSubview(nameUserTextField)
        inputContainerView.addSubview(idTextField)
        inputContainerView.addSubview(passwordTextField)
        
        setupNameUserTextField()
        setupIdTextField()
        setupPasswordTextField()
    }
    
    private func setupLoginRegisterButton () {
        // x, y, width, heigh
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 20).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupNameUserTextField() {
        nameUserTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor).isActive = true
        nameUserTextField.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor).isActive = true
        nameUserTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameUserTextFieldHeightAnchor = nameUserTextField.heightAnchor.constraint(equalToConstant: 0)
        nameUserTextFieldHeightAnchor?.isActive = true
    }
    
    func setupIdTextField() {
        idTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor).isActive = true
        idTextField.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor).isActive = true
        idTextField.topAnchor.constraint(equalTo: nameUserTextField.bottomAnchor).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func setupPasswordTextField() {
        passwordTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupLoginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -20).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalTo: idTextField.heightAnchor, multiplier: 2/3).isActive = true
    }
        
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func clearAllDidInput () {
        nameUserTextField.text = ""
        idTextField.text = ""
        passwordTextField.text = ""
    }

    func createTabViewController(id: String) {
        // Create a tab bar view controller
        let tabBarVC = UITabBarController()
        // Add Screen:
        let mInfoPage = UINavigationController(rootViewController: InfoViewController())
        let mCoursesPage = UINavigationController(rootViewController: CoursesViewController())
        let mScheduleCourse = UINavigationController(rootViewController: ScheduleViewController())
        let mResultPage = UINavigationController(rootViewController: ResultViewController())

        // Set title:
        mInfoPage.title = "Info"
        mCoursesPage.title = "Courses"
        mScheduleCourse.title = "Schedule"
        mResultPage.title = "Result"

        mInfoPage.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        mCoursesPage.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        mScheduleCourse.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        mResultPage.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        mInfoPage.navigationBar.barTintColor = loginColor
        mCoursesPage.navigationBar.barTintColor = loginColor
        mScheduleCourse.navigationBar.barTintColor = loginColor
        mResultPage.navigationBar.barTintColor = loginColor

        // add vc
        tabBarVC.setViewControllers([mInfoPage, mCoursesPage, mScheduleCourse, mResultPage], animated: true)

        guard let items = tabBarVC.tabBar.items else {
            return
        }

        let image = ["person.circle", "tray.2.fill", "calendar.badge.clock", "folder.fill.badge.person.crop"]

        for i in 0..<items.count {
            items[i].image = UIImage(systemName: image[i])
        }

        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.overrideUserInterfaceStyle = .light
        DefaultData.student.ditinit(id: id, completion: {
            self.present(tabBarVC, animated: true)
        })
    }
    
    func pushUpAlert (title: String, message: String) {
        self.clearAllDidInput()
        
        let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try again", style: .destructive, handler: { action in
            print ("try again")
        }))
        
        present(alert, animated: true)
    }
}
///"plus.rectangle.fill.on.rectangle.fill"  name for image add course

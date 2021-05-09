//
//  ViewController.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 23/04/2021.
//

import UIKit

class IntroViewController: UIViewController {

    let appIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "person.custom")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = loginColor
        view.addSubview(appIcon)
        setupAppIcon()
    }
    
    private func setupAppIcon() {
        appIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        appIcon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let login = LogInViewController()
            login.modalPresentationStyle = .fullScreen
            self.present(login, animated: true, completion: nil)
        }
    }
}


//
//  StudentAPI.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 25/04/2021.
//

import Foundation
import UIKit

struct StudentAPI {
    
    let URL = BASE_URL?.child("Student")
    
    func getPassword(id: String, completion: @escaping (String) -> Void) {
        URL?.child(id).child("Info").child("mPassword").observeSingleEvent(of: .value) { (snapShot) in
            if let password = snapShot.value as? String {
               completion(password)
            }
        }
    }
    
    func changePassword(id: String, password: String, newPassword: String, ok: @escaping () -> Void, kook: @escaping () -> Void) {
        getPassword(id: id, completion: { pass in
            if pass == password {
                URL?.child(id).child("Info").updateChildValues(["mPassword": newPassword])
                ok()
            } else {
                kook()
            }
        })
    }
    
    func createNewAccount(name: String, id: String, pass: String, completion: @escaping (Bool) -> Void) {
        URL?.child(id).child("Info").observeSingleEvent(of: .value) { (snapshot) in
            if !snapshot.exists() {
                URL?.updateChildValues([id: ["mFullName": name, "mID": id, "mPassword": pass]])
                completion(true)
            } else { completion(false) }
        }
    }
    
    func getDataOfStudentByID(id: String, completion: @escaping (Student) -> Void) {
        URL?.child(id).child("Info").observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let student = Student.transfermStudent(dictionary: dictionary)
                completion(student)
            }
        }
    }
    
    func checkExist(id: String, nonExisted: @escaping () -> Void, existed: @escaping () -> Void) {
        URL?.child(id).observeSingleEvent(of: .value) { (snapShot) in
            if !snapShot.exists() {
                nonExisted()
            } else {
                existed()
            }
        }
    }
    
    func saveInfoStudent(arrData: [[String]], completion: @escaping () -> Void) {
        URL?.child(arrData[0][0]).child("Info").updateChildValues(["mID": arrData[0][0], "mFullName": arrData[0][1] + " " + arrData[0][2], "mGender": arrData[0][3], "mIdentityNumber": arrData[0][4], "mEmail": arrData[0][5], "mPhone": arrData[0][6], "mPassword": arrData[0][7], "mBank": arrData[1][0], "mBankNumber": arrData[1][1], "mBranch": arrData[1][2]])
    }
    
    func getOverview (completion: @escaping () -> Void) {
        URL?.child(DefaultData.student.mStudentID!).child("Overview").observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                DefaultData.overview.convert(dictionary: dictionary)
                completion()
            }
        }
    }
}

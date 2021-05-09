//
//  CourseAPI.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 08/05/2021.
//

import Foundation

struct CourseAPI {
    let URL_Student = BASE_URL?.child("Student")
    let URL_CanEnrollCourse = BASE_URL?.child("CanEnrollCourse")
    
    func getEnrolled(completion: @escaping ([[String]])->Void) {
        URL_Student?.child(DefaultData.student.mStudentID!).child("Enrolled").observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                var array = [[String]]()
                let nameCourse = Array(dictionary.allKeys) as! [String]
                let score = Array(dictionary.allValues) as! [String]
                for i in 0..<dictionary.count {
                    array.append([nameCourse[i], score[i]])
                }
                completion(array)
            }
        }
    }
    
    func getCourseCompleted (completion: @escaping ()->Void, thereNoData: @escaping ()->Void) {
        URL_Student?.child(DefaultData.student.mStudentID!).child("CourseCompleted").observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                DefaultData.listCourseComplete.readData(dictionary: dictionary)
                completion()
            } else {
                thereNoData()
            }
        }
    }
    
    func getCanEnrollCourse(completion: @escaping ([CanErollCourse]) -> Void) {
        URL_CanEnrollCourse?.observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? Array<NSDictionary> {
                var array = [CanErollCourse]()
                for i in 0 ..< dictionary.count {
                    let element = CanErollCourse.transformCourse(dictionay: dictionary[i])
                    array.append(element)
                }
                completion(array)
            }
        }
    }
    
    func getCurrentCourse(completion: @escaping () -> Void) {
        URL_Student?.child(DefaultData.student.mStudentID!).child("CurrentCourses").observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? Array<NSDictionary> {
                DefaultData.listOfCurrentCourse.getData(array: dictionary)
                DefaultData.listOfCurrentCourse.convertDataToArray()
                completion()
            }
        }
    }
}

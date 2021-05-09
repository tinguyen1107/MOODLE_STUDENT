//
//  CourseCompleted.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 09/05/2021.
//

import Foundation

class CourseCompleted {
    var id = String()
    var score = String()
    var year = String()
    var semester = String()
    
    func convertToArray (datas: [CourseCompleted]) -> [[String]] {
        var array = [[String]]()
        for data in datas {
            array.append([data.id, data.year, data.semester, data.score])
        }
        return array
    }
    
    init (_ id: String, _ year: String, _ semester: String, _ score: String) {
        self.id = id
        self.year = year
        self.semester = semester
        self.score = score
    }
}

class ListCourseCompleted {
    var list = [CourseCompleted]()
    
    func readData (dictionary: NSDictionary) {
        let years = Array(dictionary.allKeys) as! Array<String>
        for year in years {
            let semesters = dictionary[year] as! Array<NSDictionary>
            for i in 0 ..< semesters.count {
                let courseName = Array(semesters[i].allKeys) as! Array<String>
                let courseScore = Array(semesters[i].allValues) as! Array<String>
                for j in 0..<courseName.count {
                    let course = CourseCompleted(courseName[j], year, String(i+1),  courseScore[j])
                    list.append(course)
                }
            }
        }
        list = list.reversed()
    }
}

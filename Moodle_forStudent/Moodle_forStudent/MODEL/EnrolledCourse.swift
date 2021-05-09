//
//  Course.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 23/04/2021.
//

import Foundation

class EnrolledCourse {

    var enrolled = [[String]]()    
    
    func ditinit(completion: @escaping ()->Void) {
        API.course.getEnrolled(completion: { array in
            self.enrolled = array
            completion()
        })
    }
}

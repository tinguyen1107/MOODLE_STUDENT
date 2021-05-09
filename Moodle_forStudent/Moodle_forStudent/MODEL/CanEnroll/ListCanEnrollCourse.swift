//
//  ListCanEnrollCourse.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 09/05/2021.
//

import Foundation

class ListCanEnrollCourse {
    
    var list = [CanErollCourse]()
    
    func ditinit(completion: @escaping ()->Void) {
        API.course.getCanEnrollCourse(completion: { array in
            self.list = array
            completion()
        })
    }
}

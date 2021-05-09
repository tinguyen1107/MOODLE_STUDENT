//
//  CanEnrollCourse.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 09/05/2021.
//

import Foundation

class CanErollCourse {
    var mID = String()
    var mTimeInterval = String()
    var Current = Int()
    var Maximum = Int()
    
    static func transformCourse (dictionay: NSDictionary) -> CanErollCourse {
        let data = CanErollCourse()
        data.mID = dictionay["ID"] as! String
        data.mTimeInterval = dictionay["TimeInterval"] as! String
        data.Current = dictionay["Current"] as! Int
        data.Maximum = dictionay["Maximum"] as! Int
        return data
    }
}

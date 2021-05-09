//
//  Overview.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 09/05/2021.
//

import Foundation

class Overview {
    var mTotalCredit = Int()
    var mTotalGPA = Int()
    var mGraduation = Bool()
    
    var arr = [String]()
    
    func convert (dictionary: NSDictionary) {
        self.mTotalCredit = dictionary["TotalCredit"] as! Int
        self.mTotalGPA = dictionary["TotalGPA"] as! Int
        self.mGraduation = dictionary["Graduation"] as! Bool
        
        self.arr = [String(mTotalCredit), String(Float(mTotalGPA)/100.0), mGraduation ? "YES" : "NO"]
    }
}

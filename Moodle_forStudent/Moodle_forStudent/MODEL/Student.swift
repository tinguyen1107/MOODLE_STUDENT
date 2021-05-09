//
//  Student.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 23/04/2021.
//
import Foundation

class Student {

    var mStudentID: String?
    var mPassword: String?

    var mName: String?
    var mFirstName: String?
    var mLastName: String?

    var mGender: String?
    var mIdentityNumber: String?
    var mEmail: String?
    var mPhoneNumber: String?
    
    var mBank: String?
    var mBankNumber: String?
    var mBranch: String?
    
    var mListOfCourseID: [String]
    
    var sourceArrayData: [[String]]
    
    init() {
        mStudentID = ""
        mPassword = ""
        mName = ""
        mGender = ""
        mIdentityNumber = ""
        mEmail = ""
        mPhoneNumber = ""
        sourceArrayData = [[]]
        mListOfCourseID = []
    }
    
    func ditinit(id: String, completion: @escaping ()->Void) {
        let empty = "nothing"
        
        sourceArrayData.removeAll()
        
        API.student.getDataOfStudentByID(id: id, completion: { [self] (student) in
            mStudentID = student.mStudentID
            mPassword = student.mPassword
            
            mName = student.mName
            
            mGender = student.mGender
            mIdentityNumber = student.mIdentityNumber
            mEmail = student.mEmail
            mPhoneNumber = student.mPhoneNumber
            
            mBank = student.mBank
            mBankNumber = student.mBankNumber
            mBranch = student.mBranch
            
            let fullnameArr = (mName ?? "nothing nothing").components(separatedBy: " ")
            var lastName: String = ""
            for i in 0..<(fullnameArr.count-2) {
                lastName += fullnameArr[i] + " "
            }
            lastName += fullnameArr[fullnameArr.count-2]
            
            sourceArrayData.append([mStudentID ?? empty, lastName, fullnameArr[fullnameArr.count - 1], mGender ?? empty, mIdentityNumber ?? empty, mEmail ?? empty, mPhoneNumber ?? empty, mPassword ?? empty])
            sourceArrayData.append([mBank ?? empty, mBankNumber ?? empty, mBranch ?? empty])
            completion()
        })
    }
    
    static func transfermStudent(dictionary: NSDictionary) -> Student {
        let stu = Student()
        
        stu.mStudentID = dictionary["mID"] as? String
        stu.mPassword = dictionary["mPassword"] as? String
        
        stu.mName = dictionary["mFullName"] as? String
        
        stu.mGender = dictionary["mGender"] as? String
        stu.mIdentityNumber = dictionary["mIdentityNumber"] as? String
        stu.mEmail = dictionary["mEmail"] as? String
        stu.mPhoneNumber = dictionary["mPhone"] as? String
        
        stu.mBank = dictionary["mBank"] as? String
        stu.mBankNumber = dictionary["mBankNumber"] as? String
        stu.mBranch = dictionary["mBranch"] as? String
        return stu
    }
}

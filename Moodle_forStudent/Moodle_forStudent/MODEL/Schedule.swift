//
//  Schedule.swift
//  Moodle_forStudent
//
//  Created by Trọng Tín on 09/05/2021.
//

import Foundation

class Schedule {
    var day = String()
    var room = String()
    var session = String()
    
    static func convertDay (day: String) -> String {
        switch day {
        case "2":
            return "Monday"
        case "3":
            return "Tuesday"
        case "4":
            return "Wednesday"
        case "5":
            return "Thursday"
        case "6":
            return "Friday"
        case "7":
            return "Saturday"
        case "8":
            return "Sunday"
        default:
            return "?"
        }
    }
}

class Deadline {
    var date = String()
    var title = String()
    var note = String()
}

class CurrentCourses {
    var id = String()
    var schedule = [Schedule]()
    var deadline = [Deadline]()
}

class ListCurrentCourses {
    var data = [CurrentCourses]()
    
    var arraySchedule = [[[String]]]()
    var arrayDeadline = [[String]]()
    
    func getData (array: Array<NSDictionary>) {
        for dictionary in array {
            let course = CurrentCourses()
            course.id = dictionary["ID"] as! String
            let arrSchedule = dictionary["Schedule"] as! Array<NSDictionary>
            for schedule in arrSchedule {
                let sche = Schedule()
                sche.day = schedule["Day"] as! String
                sche.room = schedule["Room"] as! String
                sche.session = schedule["Session"] as! String
                course.schedule.append(sche)
            }
            let arrDeadline = dictionary["Deadline"] as! Array<NSDictionary>
            for deadline in arrDeadline {
                let dl = Deadline()
                dl.date = deadline["Date"] as! String
                dl.note = deadline["Note"] as! String
                dl.title = deadline["Title"] as! String
                course.deadline.append(dl)
            }
            data.append(course)
        }
    }
    
    func convertDataToArray () {
        var arr = [[[String]]]()
        for i in 2...8 {
            arr.append([[Schedule.convertDay(day: String(i))]])
        }
        for course in data {
            if course.deadline.count != 0 {
                for deadline in course.deadline {
                    arrayDeadline.append([course.id, deadline.date, deadline.title, deadline.note])
                }
            }
            for schedule in course.schedule {
                for i in 0...6 {
                    if Schedule.convertDay(day: schedule.day) == arr[i][0][0] {
                        arr[i].append([schedule.session, course.id, schedule.room])
                        break
                    }
                }
            }
        }
        var n = 0
        while (n < arr.count) {
            if arr[n].count == 1 {
                arr.remove(at: n)
                n -= 1
            }
            n += 1
        }
        arraySchedule = arr
    }
}

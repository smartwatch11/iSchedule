//
//  RealmManager.swift
//  iSchedule
//
//  Created by Egor Rybin on 30.11.2023.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    //scheduleModel
    func saveScheduleModel(model: ScheduleModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func deleteScheduleModel(model: ScheduleModel) {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func updateScheduleModel(model: ScheduleModel, nameArray: [[String]], weekDay: Int) {
        try! realm.write {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let date = dateFormatter.date(from: nameArray[0][0])!
            model.scheduleDate = date
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let time = timeFormatter.date(from: nameArray[0][1])!
            model.scheduleTime = time
            
            model.scheduleName = nameArray[1][0]
            model.scheduleType = nameArray[1][1]
            model.scheduleBuilding = nameArray[1][2]
            model.scheduleClassroom = nameArray[1][3]
            model.scheduleTeacher = nameArray[2][0]
            model.scheduleColor = nameArray[3][0]
            model.scheduleRepeat = Bool(nameArray[4][0])!
            model.scheduleWeekday = weekDay
        }
    }
    
    // TaskModel
    func saveTaskModel(model: TaskModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func deleteTaskModel(model: TaskModel) {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func updateReadyButtonTaskModel(task: TaskModel, bool: Bool) {
        try! realm.write {
            task.taskDone = bool
        }
    }
    
    func updateTaskModel(model: TaskModel, nameArray: [String]) {
        try! realm.write {
            //print(nameArray)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let date = dateFormatter.date(from: nameArray[0])!
            model.taskDate = date
            model.taskLesson = nameArray[1]
            model.taskDesc = nameArray[2]
            model.taskColor = nameArray[3]
            model.taskDone = model.taskDone
        }
    }
    
    // ContactsModel
    func saveContactsModel(model: ContactsModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func deleteContactsModel(model: ContactsModel) {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func updateContactsModel(model: ContactsModel, nameArray: [String], imageData: Data?) {
        try! realm.write {
            model.contactName = nameArray[0]
            model.contactPhone = nameArray[1]
            model.contactEmail = nameArray[2]
            model.contactType = nameArray[3]
            model.contactAvatar = imageData
        }
    }
}

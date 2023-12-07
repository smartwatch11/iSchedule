//
//  TaskModel.swift
//  iSchedule
//
//  Created by Egor Rybin on 03.12.2023.
//

import RealmSwift

class TaskModel: Object {
    
    @Persisted var taskDate: Date?
    @Persisted var taskLesson: String = "Unknown"
    @Persisted var taskDesc: String = "Task"
    @Persisted var taskColor: String = "006DFF"
    @Persisted var taskDone: Bool = false
}

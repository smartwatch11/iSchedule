//
//  ScheduleModel.swift
//  iSchedule
//
//  Created by Egor Rybin on 29.11.2023.
//

import RealmSwift

class ScheduleModel: Object {
    
    @Persisted var scheduleDate: Date?
    @Persisted var scheduleTime: Date?
    @Persisted var scheduleName: String = "Unknown"
    @Persisted var scheduleType: String = "Not selected"
    @Persisted var scheduleBuilding: String = "Not selected"
    @Persisted var scheduleClassroom: String = "Not selected"
    @Persisted var scheduleTeacher: String = "Unknown"
    @Persisted var scheduleColor: String = "006DFF"
    @Persisted var scheduleRepeat: Bool = true
    @Persisted var scheduleWeekday: Int = 1
}

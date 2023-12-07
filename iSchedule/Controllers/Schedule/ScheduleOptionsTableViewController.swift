//
//  OptionsScheduleViewController.swift
//  iSchedule
//
//  Created by Egor Rybin on 28.11.2023.
//

import UIKit

class ScheduleOptionsTableViewController: UITableViewController {
    
    private let idOptionsSchedule = "idOptionsSchedule"
    private let idOptionsHeaderSchedule = "idOptionsHeaderSchedule"
    
    let headerNameArray = ["DATE AND TIME", "LESSON", "TEACHER", "COLOR", "PERIOD"]
    
    var cellNameArray = [["Date","Time"],["Name","Type","Building","Classroom"],["Teacher Name"],[""],["Repeat every 7 days"]]
    
    var scheduleModel = ScheduleModel()
    var editModel = false
    
    var hexColorCell: String = "006DFF"
    var swicthValue: Bool?
    var weekDay: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsSchedule)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeaderSchedule)
        //print(cellNameArray)
        hexColorCell = scheduleModel.scheduleColor
        swicthValue = scheduleModel.scheduleRepeat
        cellNameArray[4][0] = "Repeat every 7 days"
        title = "Options Schedule"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnTapped))
        
    }
    
    @objc func saveBtnTapped(){

        if cellNameArray[0][0] == "Date" || cellNameArray[0][1] == "Time" || cellNameArray[1][0] == "Name" {
            alertOk(title: "Error", message: "Date, Time and Name are required!")
        } else if editModel == false {
            setModel()
            scheduleModel.scheduleColor = hexColorCell
            print(scheduleModel)
            RealmManager.shared.saveScheduleModel(model: scheduleModel)
            scheduleModel = ScheduleModel()
            self.navigationController?.popViewController(animated: true)
            alertOk(title: "Success", message: nil)
            //hexColorCell = "006DFF"
            //tableView.reloadData()
        } else {
            cellNameArray[3][0] = hexColorCell
            cellNameArray[4][0] = String(swicthValue!)
            print(scheduleModel)
            print(cellNameArray)
            RealmManager.shared.updateScheduleModel(model: scheduleModel, nameArray: cellNameArray, weekDay: weekDay ?? scheduleModel.scheduleWeekday)
            scheduleModel = ScheduleModel()
            self.navigationController?.popViewController(animated: true)
            alertOk(title: "Success", message: nil)
        }
    }
    
    private func setModel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: cellNameArray[0][0])!
        scheduleModel.scheduleDate = date
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let time = timeFormatter.date(from: cellNameArray[0][1])!
        scheduleModel.scheduleTime = time
        
        scheduleModel.scheduleName = cellNameArray[1][0]
        scheduleModel.scheduleType = cellNameArray[1][1]
        scheduleModel.scheduleBuilding = cellNameArray[1][2]
        scheduleModel.scheduleClassroom = cellNameArray[1][3]
        
        scheduleModel.scheduleTeacher = cellNameArray[2][0]
        scheduleModel.scheduleColor = hexColorCell
        scheduleModel.scheduleRepeat = swicthValue!
        scheduleModel.scheduleWeekday = weekDay!
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 2
            case 1: return 4
            case 2: return 1
            case 3: return 1
            default: 
                return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsSchedule, for: indexPath) as! OptionsTableViewCell
        cell.cellScheduleConfigure(nameArray: cellNameArray,indexPath: indexPath, hexColor: hexColorCell, repSwitch: swicthValue!)
        cell.switchRepeatDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsHeaderSchedule) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray,section: section)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        switch indexPath {
        case [0,0]: alertDate(label: cell.nameCellLabel) { (numberWeekDay, date) in
            //self.scheduleModel.scheduleDate = date
            //self.scheduleModel.scheduleWeekday = numberWeekDay
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            self.cellNameArray[0][0] = dateFormatter.string(from: date)
            self.weekDay = numberWeekDay
        }
        case [0, 1]: alertTime(label: cell.nameCellLabel) { 
            time in
            //self.scheduleModel.scheduleTime = time
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            self.cellNameArray[0][1] = dateFormatter.string(from: time)
        }
        case[1,0]: alertForCellName(label: cell.nameCellLabel, name: "Name Lesson", placeholder: "Enter lesson name") {  text in
            //self.scheduleModel.scheduleName = text
            self.cellNameArray[1][0] = text
        }
            
        case[1,1]: alertForCellName(label: cell.nameCellLabel, name: "Type", placeholder: "Enter a type lesson"){text in
            //self.scheduleModel.scheduleType = text
            self.cellNameArray[1][1] = text
        }
        case[1,2]: alertForCellName(label: cell.nameCellLabel, name: "Building", placeholder: "Enter number of building"){  text in
            //self.scheduleModel.scheduleBuilding = text
            self.cellNameArray[1][2] = text
        }
        case[1,3]: alertForCellName(label: cell.nameCellLabel, name: "Classroom", placeholder: "Enter a number of classroom"){  text in
//            self.scheduleModel.scheduleClassroom = text
            self.cellNameArray[1][3] = text
        }
        case[2,0]: pushControllers(vc: TeachersTableViewController())
        case[3,0]: pushControllers(vc: ScheduleColorViewController())
        default:
            print("Tap OptionsTableView")
        }
    }
    
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension ScheduleOptionsTableViewController: SwitchRepeatProtocol {
    func SwitchRepeat(value: Bool) {
        //scheduleModel.scheduleRepeat = value
        swicthValue = value
    }
    
}

//
//  TaskOptionTableView.swift
//  iSchedule
//
//  Created by Egor Rybin on 28.11.2023.
//

import UIKit

class TasksOptionsTableView: UITableViewController {
    
    private let idOptionsTask = "idOptionsTask"
    private let idOptionsHeaderTasks = "idOptionsHeaderTasks"
    
    let headerNameArray = ["DATE", "LESSON", "TASK", "COLOR"]
    
    var cellNameArray = ["Date", "Lesson", "Task", ""]
    
    var hexColorCell = "006DFF"
    
    var taskModel = TaskModel()
    var editModel = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsTask)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeaderTasks)
        
        hexColorCell = taskModel.taskColor
        title = "Tasks Options"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnTapped))
        
    }
    
    @objc func saveBtnTapped(){
        
        if cellNameArray[0] == "Date" || cellNameArray[2] == "Task" {
            alertOk(title: "Error", message: "Date and Task are required!")
        } else if editModel == false {
            setModel()
            taskModel.taskColor = hexColorCell
            //print(taskModel)
            RealmManager.shared.saveTaskModel(model: taskModel)
            taskModel = TaskModel()
            self.navigationController?.popViewController(animated: true)
            alertOk(title: "Success", message: nil)
            
        } else {
            cellNameArray[3] = hexColorCell
            RealmManager.shared.updateTaskModel(model: taskModel, nameArray: cellNameArray)
            taskModel = TaskModel()
            self.navigationController?.popViewController(animated: true)
            alertOk(title: "Success", message: nil)
        }
    }
    
    private func setModel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: cellNameArray[0])!
        taskModel.taskDate = date
//        print(taskModel)
        taskModel.taskLesson = cellNameArray[1]
        taskModel.taskDesc = cellNameArray[2]
        taskModel.taskColor = hexColorCell//cellNameArray[3]
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTask, for: indexPath) as! OptionsTableViewCell
        cell.cellTasksConfigure(nameArray: cellNameArray,indexPath: indexPath, hexColor: hexColorCell)
        
//        if editModel == false {
//            cell.cellTasksConfigure(nameArray: cellNameArray,indexPath: indexPath, hexColor: hexColorCell)
//        } else if editModel {
//            cell.cellTasksConfigure(nameArray: cellNameArray,indexPath: indexPath, hexColor: hexColorCell)
//        } 
//        else {
//            cell.cellTasksConfigure(nameArray: cellNameArray,indexPath: indexPath, hexColor: hexColorCell)
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsHeaderTasks) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray,section: section)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        switch indexPath.section {
        case 0: alertDate(label: cell.nameCellLabel) { (numberWeekDay, date) in
            //self.taskModel.taskDate = date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            self.cellNameArray[0] = dateFormatter.string(from: date)
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Name Lesson", placeholder: "Enter lesson name"){text in
            //self.taskModel.taskLesson = text
            self.cellNameArray[1] = text
        }
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Task", placeholder: "Enter your task"){text in
            //self.taskModel.taskDesc = text
            self.cellNameArray[2] = text
        }
        case 3: pushControllers(vc: TasksColorTableViewController())
            //self.cellNameArray[3] = hexColorCell
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

//
//  TasksViewController.swift
//  iSchedule
//
//  Created by Egor Rybin on 23.11.2023.
//

import UIKit
import FSCalendar
import RealmSwift

class TasksViewController: UIViewController {

    private var calendarHeightConstraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private let showHideBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let idTasksCell = "idTasksCell"
    
    private let realm = try! Realm()
    private var taskArray: Results<TaskModel>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Tasks"
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: idTasksCell)
        
        setConstraints()
        swipeAction()
        setTaskOnDay(date: calendar.today!)
        
        showHideBtn.addTarget(self, action: #selector(showHideBtnTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))
    }
    
    @objc private func addBtnTapped() {
        let taskOptions = TasksOptionsTableView()
        navigationController?.pushViewController(taskOptions, animated: true)
    }
    
    @objc private func showHideBtnTapped() {
        if calendar.scope == .week {
            //calendar.scope = .month
            calendar.setScope(.month, animated: true)
            showHideBtn.setTitle("Close calendar", for: .normal)
        } else {
            //calendar.scope = .week
            calendar.setScope(.week, animated: true)
            showHideBtn.setTitle("Open calendar", for: .normal)
        }
    }

    private func setTaskOnDay(date: Date){
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        taskArray = realm.objects(TaskModel.self).filter("taskDate BETWEEN %@", [dateStart, dateEnd])
        tableView.reloadData()
    }
    
    //MARK: SwipeGestureRecognizer
    private func swipeAction() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDowm = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDowm.direction = .down
        calendar.addGestureRecognizer(swipeDowm)
    }
    
    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            showHideBtnTapped()
        case .down:
            showHideBtnTapped()
        default:
            break
        }
    }
    
    @objc private func editingModel(taskModel: TaskModel) {
        let taskOption = TasksOptionsTableView()
        taskOption.taskModel = taskModel
        taskOption.editModel = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date  = dateFormatter.string(from: taskModel.taskDate!)
        taskOption.cellNameArray = [date, taskModel.taskLesson, taskModel.taskDesc, ""]
        navigationController?.pushViewController(taskOption, animated: true)
    }
}


extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTasksCell, for: indexPath)
        as! TasksTableViewCell
        
        cell.cellTaskDelegate = self
        cell.index = indexPath
        let model = taskArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = taskArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complitionHandler in
            RealmManager.shared.deleteTaskModel(model: editingRow)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = taskArray[indexPath.row]
        editingModel(taskModel: model)
    }
}

//MARK: PressReadyBtnProtocol
extension TasksViewController: PressReadyBtnProtocol {
    func readyButtonTapped(indexPath: IndexPath) {
        let task = taskArray[indexPath.row]
        RealmManager.shared.updateReadyButtonTaskModel(task: task, bool: !task.taskDone)
        tableView.reloadData()
    }
    
    
}

//MARK: FSCalendarDataSource, FSCalendarDelegate
extension TasksViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        setTaskOnDay(date: date)
    }
}

//MARK: SetConstraints

extension TasksViewController {
    func setConstraints() {
        view.addSubview(calendar)
        
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        
        calendar.addConstraint(calendarHeightConstraint)
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        view.addSubview(showHideBtn)
        NSLayoutConstraint.activate([
            showHideBtn.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideBtn.widthAnchor.constraint(equalToConstant: 100),
            showHideBtn.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHideBtn.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }

}

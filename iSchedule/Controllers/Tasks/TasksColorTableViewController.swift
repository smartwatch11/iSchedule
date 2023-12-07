//
//  TasksColorTableViewController.swift
//  iSchedule
//
//  Created by Egor Rybin on 28.11.2023.
//

import UIKit

class TasksColorTableViewController: UITableViewController {
    
    private let idOptionsColorTaskCell = "idOptionsColorTaskCell"
    private let idOptionsHeaderTask = "idOptionsHeaderTask"
    
    let headerNameArray = ["RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "DARK BLUE", "PURPLE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: idOptionsColorTaskCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeaderTask)
        
        title = "Color Task"
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsColorTaskCell, for: indexPath) as! ColorTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsHeaderTask) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray,section: section)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0: setColor("FF2433")
        case 1: setColor("FF9835")
        case 2: setColor("F1FF00")
        case 3: setColor("00FF00")
        case 4: setColor("00FFFF")
        case 5: setColor("006DFF")
        case 6: setColor("A926FF")
        default:
            setColor("FFFFFF")
        }
        
    }
    
    private func setColor(_ color: String){
        let taskOptions = self.navigationController?.viewControllers[1] as? TasksOptionsTableView
        taskOptions?.hexColorCell = color
        taskOptions?.tableView.reloadRows(at: [[3,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
}


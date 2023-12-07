//
//  TeachersViewController.swift
//  iSchedule
//
//  Created by Egor Rybin on 28.11.2023.
//

import UIKit
import RealmSwift

class TeachersTableViewController: UITableViewController {
    
    private let realm = try! Realm()
    private var contactsArray: Results<ContactsModel>!
    private let teacherId = "teacherId"
    
    override func viewDidLoad() {
        //print("teachers")
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Teachers"
        contactsArray = realm.objects(ContactsModel.self).filter("contactType = 'Teacher'")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: teacherId)
        
    }
    
    private func setTeacher(teacher: String) {
        let scheduleOptions = self.navigationController?.viewControllers[1] as? ScheduleOptionsTableViewController
        //scheduleOptions?.scheduleModel.scheduleTeacher = teacher
        scheduleOptions?.cellNameArray[2][0] = teacher
        scheduleOptions?.tableView.reloadRows(at: [[2,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teacherId, for: indexPath) as! ContactsTableViewCell
        let model = contactsArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactsArray[indexPath.row]
        setTeacher(teacher: model.contactName)
    }
}

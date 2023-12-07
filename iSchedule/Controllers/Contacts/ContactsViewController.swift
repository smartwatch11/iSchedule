//
//  ContactsTableViewController.swift
//  iSchedule
//
//  Created by Egor Rybin on 29.11.2023.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Friends", "Teachers"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .singleLine
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let idContactTask = "idContactTask"
    
    private let searchController = UISearchController()
    
    private let realm = try! Realm()
    private var contactsArray: Results<ContactsModel>!
    
    private var contactsFilteredArray: Results<ContactsModel>!
    
    var seacrhBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return true}
        return text.isEmpty
    }
    
    var isFiltered: Bool {
        return searchController.isActive && !seacrhBarIsEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        contactsArray = realm.objects(ContactsModel.self).filter("contactType = 'Friend'")
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        //tableView.bounces = false
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactTask)
        setConstraints()
        
        title = "Contacts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))
        
        segmentedControl.addTarget(self, action: #selector(changeSegment), for: .valueChanged)
        
    }
    
    @objc private func changeSegment() {
        if segmentedControl.selectedSegmentIndex == 0 {
            contactsArray = realm.objects(ContactsModel.self).filter("contactType = 'Friend'")
            tableView.reloadData()
        } else {
            contactsArray = realm.objects(ContactsModel.self).filter("contactType = 'Teacher'")
            tableView.reloadData()
        }
    }
    
    @objc private func addBtnTapped() {
        let contactOption = ContactsOptionsTableViewController()
        navigationController?.pushViewController(contactOption, animated: true)
    }
    
    @objc private func editingModel(contactModel: ContactsModel) {
        let contactOption = ContactsOptionsTableViewController()
        contactOption.contactsModel = contactModel
        contactOption.editModel = true
        contactOption.cellNameArray = [contactModel.contactName, contactModel.contactPhone, contactModel.contactEmail, contactModel.contactType, ""]
        contactOption.imageIsChanged = true
        navigationController?.pushViewController(contactOption, animated: true)
    }
    
    
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isFiltered ? contactsFilteredArray.count : contactsArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactTask, for: indexPath) as! ContactsTableViewCell
        let model = (isFiltered ? contactsFilteredArray[indexPath.row] : contactsArray[indexPath.row])
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactsArray[indexPath.row]
        editingModel(contactModel: model)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = contactsArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complitionHandler in
            RealmManager.shared.deleteContactsModel(model: editingRow)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContactForSearch(searchController.searchBar.text!)
    }
    
    private func filterContactForSearch(_ searchText: String) {
        contactsFilteredArray = contactsArray.filter("contactName CONTAINS[c] %@", searchText)
        tableView.reloadData()
    }
    
    
}

extension ContactsViewController {
    
    private func setConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView], axis: .vertical, spacing: 0, distribution: .equalSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

//
//  ViewController.swift
//  iSchedule
//
//  Created by Egor Rybin on 23.11.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
    }
    
    func setupTabBar() {
        let scheduleViewController = createNavController(vc: ScheduleViewController(), itemName: "Schedule", itemImage: "calendar.badge.clock")
        let tasksViewController = createNavController(vc: TasksViewController(), itemName: "Task", itemImage: "doc.plaintext")
        let contactsViewController = createNavController(vc: ContactsViewController(), itemName: "Contacts", itemImage: "person.3")
        
        viewControllers = [scheduleViewController, tasksViewController, contactsViewController]
    }
    
    func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 5)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        //navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        
        return navController
    }


}


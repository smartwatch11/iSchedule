//
//  AlertContact.swift
//  iSchedule
//
//  Created by Egor Rybin on 29.11.2023.
//

import UIKit

extension UIViewController {
    func alertContact(label: UILabel, completionHandler: @escaping (String)->Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let friend = UIAlertAction(title: "Friend", style: .default) { _ in
            label.text = "Friend"
            let typeContact = "Friend"
            completionHandler(typeContact)
        }
        
        let teacher = UIAlertAction(title: "Teacher", style: .default) { _ in
            label.text = "Teacher"
            let typeContact = "Teacher"
            completionHandler(typeContact)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(friend)
        alert.addAction(teacher)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}

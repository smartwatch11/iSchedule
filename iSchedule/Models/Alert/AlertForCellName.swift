//
//  AlertForCellName.swift
//  iSchedule
//
//  Created by Egor Rybin on 28.11.2023.
//

import UIKit

extension UIViewController {
    
    func alertForCellName(label: UILabel, name: String, placeholder: String, copmlitionHandler: @escaping (String)->Void) {
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            
            let tfAlert = alert.textFields?.first
            guard let text = tfAlert?.text else {return}
            label.text = (text != "" ? text : label.text)
            copmlitionHandler(text)
        }
        
        alert.addTextField { (tfAlert) in
            tfAlert.placeholder = placeholder
        }
        
        let cancel = UIAlertAction(title: "CANCEL", style: .default, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

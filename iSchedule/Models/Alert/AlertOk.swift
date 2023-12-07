//
//  AlertOk.swift
//  iSchedule
//
//  Created by Egor Rybin on 30.11.2023.
//

import UIKit

extension UIViewController {
    
    func alertOk(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}

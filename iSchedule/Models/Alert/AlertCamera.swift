//
//  AlertCamera.swift
//  iSchedule
//
//  Created by Egor Rybin on 29.11.2023.
//

import UIKit

extension UIViewController {
    func alertCamera(completionHandler: @escaping (UIImagePickerController.SourceType)->Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            let camera = UIImagePickerController.SourceType.camera
            completionHandler(camera)
        }
        
        let gallery = UIAlertAction(title: "Gallery", style: .default) { _ in
            let gallery = UIImagePickerController.SourceType.photoLibrary
            completionHandler(gallery)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}

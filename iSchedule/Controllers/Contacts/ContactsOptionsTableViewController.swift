//
//  ContactOptionViewController.swift
//  iSchedule
//
//  Created by Egor Rybin on 29.11.2023.
//

import UIKit

class ContactsOptionsTableViewController: UITableViewController {
    
    private let idOptionsContact = "idOptionsContact"
    private let idOptionsHeaderContact = "idOptionsHeaderContact"
    
    let headerNameArray = ["NAME", "PHONE", "MAIL", "TYPE", "AVATAR"]
    
    var cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
    
    var imageIsChanged = false
    var contactsModel = ContactsModel()
    var editModel = false
    var dataImage: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsContact)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeaderContact)
        
        title = "Options Contacts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnTapped))
        
    }
    
    @objc func saveBtnTapped(){
        
        if cellNameArray[0] == "Name" || cellNameArray[3] == "Type" {
            alertOk(title: "Error", message: "Date and Task are required!")
        } else if editModel == false{
            setImageModel()
            setModel()
            RealmManager.shared.saveContactsModel(model: contactsModel)
            contactsModel = ContactsModel()
            self.navigationController?.popViewController(animated: true)
            alertOk(title: "Success", message: nil)
            //hexColorCell = "006DFF"
            //tableView.reloadData()
        } else {
            setImageModel()
            RealmManager.shared.updateContactsModel(model: contactsModel, nameArray: cellNameArray, imageData: dataImage)
            self.navigationController?.popViewController(animated: true)
            alertOk(title: "Success", message: nil)
        }
    }
    
    @objc private func setImageModel() {
        if imageIsChanged {
            let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
            let image = cell.backgraundViewCell.image
            guard let imageData = image?.pngData() else {return}
            dataImage = imageData
            
            cell.backgraundViewCell.contentMode = .scaleAspectFit
            imageIsChanged = false
        } else {
            dataImage = nil
        }
    }
    
    private func setModel() {
        contactsModel.contactName = cellNameArray[0]
        contactsModel.contactPhone = cellNameArray[1]
        contactsModel.contactEmail = cellNameArray[2]
        contactsModel.contactType = cellNameArray[3]
        contactsModel.contactAvatar = dataImage
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContact, for: indexPath) as! OptionsTableViewCell
        if editModel == false {
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        } else if let data = contactsModel.contactAvatar, let image = UIImage(data: data) {
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: image)
        } else {
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 4 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsHeaderContact) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray,section: section)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        switch indexPath.section {
        case 0: alertForCellName(label: cell.nameCellLabel, name: "Name Contact", placeholder: "Enter contact name"){text in
            //self.contactsModel.contactName = text
            self.cellNameArray[0] = text
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Phone Contact", placeholder: "Enter contact phone"){text in
//            self.contactsModel.contactPhone = text
            self.cellNameArray[1] = text
        }
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Mail Contact", placeholder: "Enter contact mail"){text in
//            self.contactsModel.contactEmail = text
            self.cellNameArray[2] = text
        }
        case 3: alertContact(label: cell.nameCellLabel) { (type) in
//            self.contactsModel.contactType = type
            self.cellNameArray[3] = type
        }
        case 4: alertCamera { [self] source in
            chooseImagePicker(source: source)
        }
        default:
            print("Tap ContactOptionsTableView")
        }
    }
    
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ContactsOptionsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
        cell.backgraundViewCell.image = info[.editedImage] as? UIImage
        cell.backgraundViewCell.contentMode = .scaleAspectFill
        cell.backgraundViewCell.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
}

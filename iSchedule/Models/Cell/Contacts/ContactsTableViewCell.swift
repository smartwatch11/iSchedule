//
//  ContactsTableViewCell.swift
//  iSchedule
//
//  Created by Egor Rybin on 29.11.2023.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    let contactImageView: UIImageView = {
        let image = UIImageView()
        //image.image = UIImage(named: "retriver")
        image.image = UIImage(systemName: "person.fill")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let phoneImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "phone.fill")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = #colorLiteral(red: 0.3479160666, green: 0.4855031967, blue: 1, alpha: 1)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let mailImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "envelope.fill")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameLabel = UILabel(text: "Retriver", font: UIFont(name: "Avenir Next", size: 20)!, alignment: .left)
    let phoneLabel = UILabel(text: "+79991234563", font: UIFont(name: "Avenir Next", size: 14)!, alignment: .left)
    let mailLabel = UILabel(text: "Retriver@mail.ru", font: UIFont(name: "Avenir Next", size: 14)!, alignment: .left)
    
    override func layoutIfNeeded() {
        super.layoutSubviews()
        
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ContactsModel){
        nameLabel.text = model.contactName
        phoneLabel.text = model.contactPhone
        mailLabel.text = model.contactEmail
        
        if let data = model.contactAvatar, let image = UIImage(data: data) {
            contactImageView.image = image
        } else {
            contactImageView.image = UIImage(systemName: "person.fill")
        }
    }
    
    func setConstraints() {
        self.addSubview(contactImageView)
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            contactImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contactImageView.widthAnchor.constraint(equalToConstant: 70),
            contactImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        
        let stackView = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel, mailImageView, mailLabel], axis: .horizontal, spacing: 3, distribution: .fillProportionally)
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
    
}

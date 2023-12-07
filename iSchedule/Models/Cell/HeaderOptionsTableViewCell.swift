//
//  HeaderOptionsScheduleTableViewCell.swift
//  iSchedule
//
//  Created by Egor Rybin on 28.11.2023.
//

import UIKit

class HeaderOptionsTableViewCell: UITableViewHeaderFooterView {
    
    let headerLabel = UILabel(text: "", font: UIFont(name: "Avenir Next", size: 14)!, alignment: .left)
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        headerLabel.textColor = #colorLiteral(red: 0.2111878395, green: 0.2179464698, blue: 0.2740572393, alpha: 1)
        self.contentView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        
        
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func headerConfigure(nameArray: [String],section: Int) {
        headerLabel.text = nameArray[section]
    }
    
    func setConstraints() {
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}

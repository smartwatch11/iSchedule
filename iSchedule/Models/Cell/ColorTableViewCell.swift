//
//  ColorScheduleTableViewCell.swift
//  iSchedule
//
//  Created by Egor Rybin on 28.11.2023.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    
    let backgraundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfigure(indexPath: IndexPath) {
        switch indexPath.section {
        case 0: backgraundViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.1412024796, blue: 0.19875139, alpha: 1)
        case 1: backgraundViewCell.backgroundColor = #colorLiteral(red: 1, green: 0.5960784314, blue: 0.2078431373, alpha: 1)
        case 2: backgraundViewCell.backgroundColor = #colorLiteral(red: 0.9450980392, green: 1, blue: 0, alpha: 1)
        case 3: backgraundViewCell.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        case 4: backgraundViewCell.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1)
        case 5: backgraundViewCell.backgroundColor = #colorLiteral(red: 0, green: 0.4274509804, blue: 1, alpha: 1)
        case 6: backgraundViewCell.backgroundColor = #colorLiteral(red: 0.662745098, green: 0.1490196078, blue: 1, alpha: 1)
        default:
            print("Error")
        }
    }
    
    
    func setConstraints() {
        self.addSubview(backgraundViewCell)
        NSLayoutConstraint.activate([
            backgraundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgraundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgraundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgraundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        
    }
}

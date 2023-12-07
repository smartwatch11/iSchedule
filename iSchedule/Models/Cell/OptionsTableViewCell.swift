//
//  OptionsTableViewCell.swift
//  iSchedule
//
//  Created by Egor Rybin on 28.11.2023.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    let backgraundViewCell: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameCellLabel: UILabel = {
        let label = UILabel()
        label.text = "Cell"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    weak var switchRepeatDelegate: (SwitchRepeatProtocol)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        repeatSwitch.addTarget(self, action: #selector(switchChange), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellScheduleConfigure(nameArray: [[String]], indexPath: IndexPath, hexColor: String, repSwitch: Bool) {
        nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
        let color = UIColor().colorFromHex(hexColor)
        backgraundViewCell.backgroundColor = (indexPath.section == 3 ? color : .white)
        
        repeatSwitch.isHidden = (indexPath.section == 4 ? false : true)
        repeatSwitch.isOn = repSwitch
        repeatSwitch.onTintColor = color
    }
    
    func cellTasksConfigure(nameArray: [String], indexPath: IndexPath, hexColor: String) {
        nameCellLabel.text = nameArray[indexPath.section]
        let color = UIColor().colorFromHex(hexColor)
        backgraundViewCell.backgroundColor = (indexPath.section == 3 ? color : .white)
        
    }
    
    func cellContactConfigure(nameArray: [String], indexPath: IndexPath, image: UIImage?) {
        nameCellLabel.text = nameArray[indexPath.section]
        if image == nil {
            indexPath.section == 4 ? backgraundViewCell.image = UIImage(systemName: "person.fill.badge.plus") : nil
        } else {
            indexPath.section == 4 ? backgraundViewCell.image = image : nil
            backgraundViewCell.contentMode = .scaleAspectFill
        }
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
        switchRepeatDelegate?.SwitchRepeat(value: paramTarget.isOn)
    }
    
    func setConstraints() {
        self.addSubview(backgraundViewCell)
        NSLayoutConstraint.activate([
            backgraundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgraundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgraundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgraundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        
        self.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: backgraundViewCell.leadingAnchor, constant: 15)
        ])
        
        self.contentView.addSubview(repeatSwitch)
        NSLayoutConstraint.activate([
            repeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            repeatSwitch.trailingAnchor.constraint(equalTo: backgraundViewCell.trailingAnchor, constant: -20)
        ])
        
    }
}

//
//  ScheduleTableViewCell.swift
//  iSchedule
//
//  Created by Egor Rybin on 27.11.2023.
//

import UIKit


class ScheduleTableViewCell: UITableViewCell {
    
    let lessonName = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 20)!, alignment: .left)
    let teacherName = UILabel(text: "", font: UIFont(name: "Avenir Next", size: 20)!, alignment: .right)
    let lessonTime = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 20)!, alignment: .left)
    
    let typeLabel = UILabel(text: "Type:", font: UIFont(name: "Avenir Next", size: 14)!, alignment: .left)
    let lessonType = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14)!, alignment: .right)
    let buildingLabel = UILabel(text: "Building:", font: UIFont(name: "Avenir Next", size: 14)!, alignment: .left)
    let lessonBuilding = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14)!, alignment: .right)
    let audLabel = UILabel(text: "Classroom:", font: UIFont(name: "Avenir Next", size: 14)!, alignment: .left)
    let lessonAud = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14)!, alignment: .right)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ScheduleModel){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        lessonName.text = model.scheduleName
        teacherName.text = model.scheduleTeacher
        guard let time = model.scheduleTime else {return}
        lessonTime.text = dateFormatter.string(from: time)
        lessonType.text = model.scheduleType
        lessonBuilding.text = model.scheduleBuilding
        lessonAud.text = model.scheduleClassroom
        backgroundColor = UIColor().colorFromHex("\(model.scheduleColor)")
    }
    
    func setConstraints() {
        let topStackView = UIStackView(arrangedSubviews: [lessonName,teacherName], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        
        
        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(lessonTime)
        NSLayoutConstraint.activate([
            lessonTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            lessonTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            lessonTime.widthAnchor.constraint(equalToConstant: 100),
            lessonTime.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [typeLabel,lessonType, buildingLabel, lessonBuilding, audLabel, lessonAud], axis: .horizontal, spacing: 5, distribution: .fillProportionally)
        
        self.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: lessonTime.trailingAnchor, constant: 5),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
}

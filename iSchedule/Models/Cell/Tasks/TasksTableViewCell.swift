//
//  TasksTableViewCell.swift
//  iSchedule
//
//  Created by Egor Rybin on 28.11.2023.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    let taskName = UILabel(text: "Proga", font: UIFont(name: "Avenir Next Demi Bold", size: 20)!, alignment: .left)
    let taskDescription = UILabel(text: "Homework Homework Homework Homework Homework Homework Homework Homework Homework Homework", font: UIFont(name: "Avenir Next", size: 14)!, alignment: .left)
    
    let readyButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    weak var cellTaskDelegate: PressReadyBtnProtocol?
    var index: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        taskDescription.numberOfLines = 2
        
        setConstraints()
        
        readyButton.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: TaskModel){
        taskName.text = model.taskLesson
        taskDescription.text = model.taskDesc
        backgroundColor = UIColor().colorFromHex("\(model.taskColor)")
        
        if model.taskDone {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
        } else {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        }
    }
    
    @objc func readyButtonTapped() {
        guard let index = index else {return}
        cellTaskDelegate?.readyButtonTapped(indexPath: index)
    }
    
    func setConstraints() {
        self.contentView.addSubview(readyButton)
        NSLayoutConstraint.activate([
            readyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            readyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalToConstant: 40),
            readyButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(taskName)
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            taskName.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskName.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(taskDescription)
        NSLayoutConstraint.activate([
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 5),
            taskDescription.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
}


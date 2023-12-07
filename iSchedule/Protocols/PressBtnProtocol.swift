//
//  PressBtnProtocol.swift
//  iSchedule
//
//  Created by Egor Rybin on 28.11.2023.
//

import Foundation

protocol PressReadyBtnProtocol: AnyObject {
    func readyButtonTapped(indexPath: IndexPath)
}


protocol SwitchRepeatProtocol: AnyObject {
    func SwitchRepeat(value: Bool)
}

//
//  PushButtonGroup.swift
//  MVVMSampleIOS01
//
//  Created by velo.yamigiku on 2020/09/22.
//  Copyright © 2020 velo.yamigiku. All rights reserved.
//

import Foundation

class PushButtonGroup {
    
    static let rowCount = 3
    static let colCount = 3
    static let allCount = PushButtonGroup.rowCount * PushButtonGroup.colCount
    var buttonAry: [[PushButton]]
    var buttonDict: [Int:PushButton]
    
    init() {
        buttonAry = [[PushButton]]()
        buttonDict = [Int:PushButton]()
        var buttonNumber = 1
        for rowIdx in 0..<PushButtonGroup.rowCount {
            var rowAry: [PushButton] = [PushButton]()
            for colIdx in 0..<PushButtonGroup.colCount {
                let button = PushButton(number: buttonNumber, on: false, rowIndex: rowIdx, colIndex: colIdx)
                rowAry.append(button)
                buttonDict[buttonNumber] = button
                buttonNumber = buttonNumber + 1
            }
            buttonAry.append(rowAry)
        }
    }
    
    func push(buttonNumber: Int) {
        
        let button = buttonDict[buttonNumber]
        
        if (button!.rowIndex - 1 >= 0) {
            // flow button-update event
        }
        if (button!.rowIndex + 1 < PushButtonGroup.rowCount) {
            // flow button-update event
        }
        if (button!.colIndex - 1 >= 0) {
            // flow button-update event
        }
        if (button!.colIndex + 1 < PushButtonGroup.colCount) {
            // flow button-update event
        }
        
        if (isAllOn()) {
            // flow allon event
        }
        
    }
    
    private func isAllOn() -> Bool {
        var onCount = 0
        // on check logic
        if (onCount == PushButtonGroup.allCount) {
            return true
        } else {
            return false
        }
    }
    
}

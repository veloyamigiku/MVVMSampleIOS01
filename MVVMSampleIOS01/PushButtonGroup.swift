//
//  PushButtonGroup.swift
//  MVVMSampleIOS01
//
//  Created by velo.yamigiku on 2020/09/22.
//  Copyright © 2020 velo.yamigiku. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class PushButtonGroup {
    
    private var rowCount: Int
    private var colCount: Int
    private var allCount: Int
    private var buttonAry: [[PushButton]]
    private var buttonDict: [Int:PushButton]
    private var buttonOnOffDict: [Int:BehaviorRelay<Bool>]
    private var isAllOnRelay: BehaviorRelay<Bool>
    var isAllOn: Observable<Bool>
    //var pushedButton: PublishRelay<Int>
    private var disposeBag: DisposeBag
    
    init(rowCount: Int, colCount: Int) {
        self.disposeBag = DisposeBag()
        self.rowCount = rowCount
        self.colCount = colCount
        self.allCount = rowCount * colCount
        self.buttonAry = [[PushButton]]()
        self.buttonDict = [Int:PushButton]()
        self.buttonOnOffDict = [Int:BehaviorRelay<Bool>]()
        var buttonNumber = 1
        for rowIdx in 0..<rowCount {
            var rowAry: [PushButton] = [PushButton]()
            for colIdx in 0..<colCount {
                let button = PushButton(number: buttonNumber, on: false, rowIndex: rowIdx, colIndex: colIdx)
                rowAry.append(button)
                self.buttonDict[buttonNumber] = button
                self.buttonOnOffDict[buttonNumber] = BehaviorRelay(value: false)
                buttonNumber = buttonNumber + 1
            }
            self.buttonAry.append(rowAry)
        }
        self.isAllOnRelay = BehaviorRelay(value: false)
        self.isAllOn = isAllOnRelay.asObservable()
        /*self.pushedButton = PublishRelay()
        self.pushedButton.asObservable().subscribe(onNext: { buttonNumber in
            self.push(buttonNumber: buttonNumber)
        }).disposed(by: self.disposeBag)*/
    }
    
    func getButtonOnOff(buttonNumber: Int) -> Observable<Bool> {
        guard let buttonOnOff = buttonOnOffDict[buttonNumber] else {
            return Observable.empty()
        }
        return buttonOnOff.asObservable()
    }
    
    /*private */func push(buttonNumber: Int) {
        
        guard let button = buttonDict[buttonNumber] else {
            return
        }
        button.on = !button.on
        guard let buttonOnOff = buttonOnOffDict[buttonNumber] else {
            return
        }
        buttonOnOff.accept(button.on)
        
        if (button.rowIndex - 1 >= 0) {
            let topButton = buttonAry[button.rowIndex - 1][button.colIndex]
            topButton.on = !topButton.on
            guard let buttonOnOff = buttonOnOffDict[topButton.number] else {
                return
            }
            buttonOnOff.accept(topButton.on)
        }
        if (button.rowIndex + 1 < self.rowCount) {
            let bottomButton = buttonAry[button.rowIndex + 1][button.colIndex]
            bottomButton.on = !bottomButton.on
            guard let buttonOnOff = buttonOnOffDict[bottomButton.number] else {
                return
            }
            buttonOnOff.accept(bottomButton.on)
        }
        if (button.colIndex - 1 >= 0) {
            let leftButton = buttonAry[button.rowIndex][button.colIndex - 1]
            leftButton.on = !leftButton.on
            guard let buttonOnOff = buttonOnOffDict[leftButton.number] else {
                return
            }
            buttonOnOff.accept(leftButton.on)
        }
        if (button.colIndex + 1 < self.colCount) {
            let rightButton = buttonAry[button.rowIndex][button.colIndex + 1]
            rightButton.on = !rightButton.on
            guard let buttonOnOff = buttonOnOffDict[rightButton.number] else {
                return
            }
            buttonOnOff.accept(rightButton.on)
        }
        
        if (checkAllOn()) {
            isAllOnRelay.accept(true)
        } else {
            isAllOnRelay.accept(false)
        }
        
    }
    
    private func checkAllOn() -> Bool {
        var onCount = 0
        // on check logic
        if (onCount == self.allCount) {
            return true
        } else {
            return false
        }
    }
    
}

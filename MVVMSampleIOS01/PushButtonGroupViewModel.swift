//
//  PushButtonGroupViewModel.swift
//  MVVMSampleIOS01
//
//  Created by velo.yamigiku on 2020/10/05.
//  Copyright © 2020 velo.yamigiku. All rights reserved.
//

import RxSwift

class PushButtonGroupViewModel: NSObject {
    
    private var pushButtonGroup: PushButtonGroup
    
    init(rowCount: Int, colCount: Int) {
        pushButtonGroup = PushButtonGroup(
            rowCount: rowCount,
            colCount: colCount)
    }
    
    func getButtonOnOff(buttonNumber: Int) -> Observable<Bool> {
        return pushButtonGroup.getButtonOnOff(buttonNumber: buttonNumber)
    }
    
    func getIsAllOn() -> Observable<Bool> {
        return pushButtonGroup.isAllOn
    }
    
    func pushButton(buttonNumber: Int) {
        pushButtonGroup.push(buttonNumber: buttonNumber)
    }
    
    func clearButtons() {
        pushButtonGroup.clearButtonOnOff()
    }
    
}

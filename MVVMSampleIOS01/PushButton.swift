//
//  PushButton.swift
//  MVVMSampleIOS01
//
//  Created by velo.yamigiku on 2020/09/22.
//  Copyright © 2020 velo.yamigiku. All rights reserved.
//

import Foundation

class PushButton {
    
    private var _number: Int
    var number: Int {
        return self._number
    }
    var on: Bool
    private var _rowIndex: Int
    var rowIndex: Int {
        return self._rowIndex
    }
    private var _colIndex: Int
    var colIndex: Int {
        return self._colIndex
    }
    
    init(number: Int, on: Bool, rowIndex: Int, colIndex: Int) {
        self._number = number
        self.on = on
        self._rowIndex = rowIndex
        self._colIndex = colIndex
    }
    
}

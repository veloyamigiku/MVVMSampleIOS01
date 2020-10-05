//
//  PushButtonGroupTests.swift
//  MVVMSampleIOS01Tests
//
//  Created by Leon on 2020/09/28.
//  Copyright © 2020 Leon. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest

@testable import MVVMSampleIOS01

class PushButtonGroupTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        
    }

    override func tearDown() {}
    
    func test01() {
        // 初期化時の状態をテストする。
        let pushButtonGroup = PushButtonGroup(rowCount: 3, colCount: 3)
        let correctButtonOnOff = [
            1: false,
            2: false,
            3: false,
            4: false,
            5: false,
            6: false,
            7: false,
            8: false,
            9: false
        ]
        for correct in correctButtonOnOff {
            let buttonNumber = correct.key
            let onOff = correct.value
            XCTAssertEqual(
                try pushButtonGroup.getButtonOnOff(buttonNumber: buttonNumber).toBlocking().first(), onOff)
        }
        XCTAssertEqual(
            try pushButtonGroup.isAllOn.toBlocking().first(),
            false)
    }
    
    func test02() {
        
        let button1OnOff = scheduler.createObserver(Bool.self)
        let button2OnOff = scheduler.createObserver(Bool.self)
        let button3OnOff = scheduler.createObserver(Bool.self)
        let button4OnOff = scheduler.createObserver(Bool.self)
        let button5OnOff = scheduler.createObserver(Bool.self)
        let button6OnOff = scheduler.createObserver(Bool.self)
        let button7OnOff = scheduler.createObserver(Bool.self)
        let button8OnOff = scheduler.createObserver(Bool.self)
        let button9OnOff = scheduler.createObserver(Bool.self)
        
        // ボタン5をタップした後の状態をテストする。
        let pushButtonGroup = PushButtonGroup(
            rowCount: 3,
            colCount: 3)
        pushButtonGroup
            .getButtonOnOff(buttonNumber: 1)
            .subscribe(button1OnOff)
            .disposed(by: disposeBag)
        pushButtonGroup
            .getButtonOnOff(buttonNumber: 2)
            .subscribe(button2OnOff)
            .disposed(by: disposeBag)
        pushButtonGroup
            .getButtonOnOff(buttonNumber: 3)
            .subscribe(button3OnOff)
            .disposed(by: disposeBag)
        pushButtonGroup
            .getButtonOnOff(buttonNumber: 4)
            .subscribe(button4OnOff)
            .disposed(by: disposeBag)
        pushButtonGroup
            .getButtonOnOff(buttonNumber: 5)
            .subscribe(button5OnOff)
            .disposed(by: disposeBag)
        pushButtonGroup
            .getButtonOnOff(buttonNumber: 6)
            .subscribe(button6OnOff)
            .disposed(by: disposeBag)
        pushButtonGroup
            .getButtonOnOff(buttonNumber: 7)
            .subscribe(button7OnOff)
            .disposed(by: disposeBag)
        pushButtonGroup
            .getButtonOnOff(buttonNumber: 8)
            .subscribe(button8OnOff)
            .disposed(by: disposeBag)
        pushButtonGroup
            .getButtonOnOff(buttonNumber: 9)
            .subscribe(button9OnOff)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
        //scheduler.createHotObservable([
            .next(10, 5)])
            .subscribe({ buttonNumber in
                pushButtonGroup.push(buttonNumber: buttonNumber.element!)
            })
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(
            button1OnOff.events,
            [
            .next(0, false)
        ])
        XCTAssertEqual(
            button2OnOff.events,
            [
            .next(0, false),
            .next(10, true)
        ])
        XCTAssertEqual(
            button3OnOff.events,
            [
            .next(0, false)
        ])
        XCTAssertEqual(
            button4OnOff.events,
            [
            .next(0, false),
            .next(10, true)
        ])
        XCTAssertEqual(
            button5OnOff.events,
            [
            .next(0, false),
            .next(10, true)
        ])
        XCTAssertEqual(
            button6OnOff.events,
            [
            .next(0, false),
            .next(10, true)
        ])
        XCTAssertEqual(
            button7OnOff.events,
            [
            .next(0, false)
        ])
        XCTAssertEqual(
            button8OnOff.events,
            [
            .next(0, false),
            .next(10, true)
        ])
        XCTAssertEqual(
            button9OnOff.events,
            [
            .next(0, false)
        ])
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  ViewController.swift
//  MVVMSampleIOS01
//
//  Created by velo.yamigiku on 2020/09/22.
//  Copyright © 2020 velo.yamigiku. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    private var disposeBag: DisposeBag!
    private var pbgVm: PushButtonGroupViewModel!
    private var buttonAry: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disposeBag = DisposeBag()
        pbgVm = PushButtonGroupViewModel(
            rowCount: 3,
            colCount: 3)
        buttonAry = [
            button1,
            button2,
            button3,
            button4,
            button5,
            button6,
            button7,
            button8,
            button9
        ]
        bindWithViewModel()
        
    }
    
    func bindWithViewModel() {
        
        for (index, button) in buttonAry.enumerated() {
            
            button.rx.tap.subscribe(onNext: { () in
                self.pbgVm.pushButton(buttonNumber: index + 1)
            })
            .disposed(by: disposeBag)
            
            pbgVm.getButtonOnOff(buttonNumber: index + 1).subscribe(onNext: { onOff in
                if onOff {
                    button.backgroundColor = UIColor.red
                } else {
                    button.backgroundColor = UIColor.gray
                }
            })
            .disposed(by: disposeBag)
            
        }
        
        pbgVm.getIsAllOn().subscribe(onNext: { isAllOn in
            if isAllOn {
                let dialog = UIAlertController(
                    title: "Puzzle",
                    message: "Puzzle Clear",
                    preferredStyle: .alert)
                dialog.addAction(UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: { (action: UIAlertAction!) in
                        self.pbgVm.clearButtons()
                }))
                self.present(
                    dialog,
                    animated: true,
                    completion: nil)
            }
        })
        .disposed(by: disposeBag)
        
    }

}

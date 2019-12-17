//
//  DriverSampleViewController.swift
//  test
//
//  Created by ono on 2019/12/17.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DriverSampleViewController: UIViewController {

    @IBOutlet weak var sampleBtn: UIButton!
    @IBOutlet weak var sampleSwitch: UISwitch!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sampleBtn.rx.tap.asDriver().drive(
            onNext: { print("tap!") }
        ).disposed(by: disposeBag)
        
        sampleSwitch.rx.isOn.asDriver().drive(
            onNext: { bool in
                print(bool ? "ON" : "OFF")
            }
        ).disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  UITextFieldRxViewController.swift
//  test
//
//  Created by ono on 2019/12/16.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UITextFieldRxViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField1.rx.controlEvent([UIControl.Event.editingDidBegin])
            .asDriver().drive(onNext: { _ in
                print("入力欄１で入力を開始しました！")
            }).disposed(by: disposeBag)
        
        textField2.rx.controlEvent([UIControl.Event.editingDidBegin])
            .asDriver().drive(onNext: { _ in
                print("入力欄２で入力を開始しました！")
            }).disposed(by: disposeBag)
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

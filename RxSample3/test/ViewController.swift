//
//  ViewController.swift
//  test
//
//  Created by ono on 2019/12/17.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.rx.text.orEmpty
            .filter { $0.count >= 3 }
            .map { "入力した文字数は\($0.count)です" }
            .bind(to: self.label.rx.text)
            .disposed(by: disposeBag)
    }
}


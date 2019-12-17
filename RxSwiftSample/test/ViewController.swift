//
//  ViewController.swift
//  test
//
//  Created by ono on 2019/12/16.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.rx.text.orEmpty
            .map{$0.description}
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }

}


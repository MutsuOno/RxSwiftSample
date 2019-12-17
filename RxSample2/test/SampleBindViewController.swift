//
//  SampleBindViewController.swift
//  test
//
//  Created by ono on 2019/12/17.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SampleBindViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textField.rx.text
            .bind(to: self.label.rx.text)
            .disposed(by: disposeBag)
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

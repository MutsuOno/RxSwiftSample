//
//  UIButtonRxViewController.swift
//  test
//
//  Created by ono on 2019/12/16.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UIButtonRxViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.rx.tap.subscribe(onNext: {
            print("ボタンを押しました！")
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

//
//  ObSampleViewController.swift
//  test
//
//  Created by ono on 2019/12/17.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ObSampleViewController: UIViewController {
    
    let inputText = Variable<String>("")
    let submitTrigger = PublishSubject<Void>()
    let disposeBag = DisposeBag()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0

        self.textView.rx.text.orEmpty
            .bind(to: self.inputText).disposed(by: disposeBag)
        
        self.inputText.asObservable().subscribe(
            onNext: { [weak self] str in
                self?.submitButton.isEnabled = str.count > 10
                self?.restLabel.text = "残り\(200-str.count)文字"
            }
        ).disposed(by: disposeBag)
        
        submitTrigger.subscribe(
            onNext: { print("送信処理実行") }
        ).disposed(by: disposeBag)
        
        submitButton.rx.tap.asDriver().drive(
            self.submitTrigger
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

//
//  ViewController.swift
//  test
//
//  Created by ono on 2019/12/19.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class ViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ログイン処理結果を返す
        let loginAction: Action<(String,String), Bool> = Action { (username, password) in
            
            // 成功
            return Observable.just(true)
        }
        
        // IDとパスワードをObservable化
        let idAndPassword = Observable.combineLatest(idTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty)
        
        // ログインボタン押下でloginActionのinputsにbind
        loginButton.rx.tap.asObservable()
            .withLatestFrom(idAndPassword)
            .bind(to: loginAction.inputs)
            .disposed(by: self.disposeBag)
        
        // ログイン後の処理
        loginAction.elements.subscribe( onNext:{ bool in
            
            if bool {
                print("login ok!")
            } else {
                print("login failed.")
            }
        }).disposed(by: self.disposeBag)
    }


}


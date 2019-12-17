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
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let helloObservable: Observable<String> = Observable.from(["H","e","l","l","o"])
        helloObservable.subscribe(
            onNext: { value in print(value) },
            onError: { error in print(error.localizedDescription) },
            onCompleted: { print("completed") }
        ).disposed(by: disposeBag)
        
        
        // ObserverTypeプロトコルを使用
        let exampleObservable: Observable<String> = Observable.create { (observer) in
            observer.on(.next("Hello"))
            observer.on(.completed)
            observer.onError(NSError(domain: "My Observable Error", code: -1, userInfo: nil))
            return Disposables.create()
        }
        exampleObservable.subscribe(
            onNext: { print($0) },
            onError: { print($0.localizedDescription) },
            onCompleted: { print("completed") }
        ).disposed(by: disposeBag)
    }


}


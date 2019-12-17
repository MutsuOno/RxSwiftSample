//
//  SubjectSampleViewController.swift
//  test
//
//  Created by ono on 2019/12/17.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubjectSampleViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // PublishSubject Class
        let subject = PublishSubject<String>()
        subject.subscribe( { print($0) }).disposed(by: disposeBag)
        // event
        subject.on(.next("a"))
        subject.on(.next("b"))
        subject.on(.next("c"))
        subject.onCompleted()
        
        // Variable Class
        let variable = Variable<String>("text")
        variable.asObservable().subscribe(onNext: { print($0) } ).disposed(by: disposeBag)
        // event
        variable.value = "a"
        variable.value = "b"
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

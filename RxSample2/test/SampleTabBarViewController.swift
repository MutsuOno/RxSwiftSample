//
//  SampleTabBarViewController.swift
//  test
//
//  Created by ono on 2019/12/17.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SampleTabBarViewController: UIViewController {
    
    
    @IBOutlet weak var tabBar: UITabBar!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBar.rx.didSelectItem.subscribe(
            onNext: {
                [weak self] tabItem in
                    // 最初に全てのアイコンのbadgeValueを空にする
                    self?.tabBar.items?.forEach{ $0.badgeValue = nil}
                    // 選択したアイコンのbadgeValueを10に
                    tabItem.badgeValue = "10"
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

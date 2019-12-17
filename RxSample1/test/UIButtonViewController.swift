//
//  UIButtonViewController.swift
//  test
//
//  Created by ono on 2019/12/16.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit

class UIButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("起動")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPush(_ sender: Any) {
        print("ボタンを押しました！")
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

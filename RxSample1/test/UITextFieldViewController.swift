//
//  UITextFieldViewController.swift
//  test
//
//  Created by ono on 2019/12/16.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit

class UITextFieldViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension UITextFieldViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case textField1:
            print("入力欄１で入力を開始しました")
        case textField2:
            print("入力欄２で入力を開始しました")
        default:
            break
        }
    }
}

//
//  ViewController.swift
//  test
//
//  Created by ono on 2019/12/20.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bind()
    }

    func bind() {
        
        // 入力欄の値とinputs.searchWordをbind
        self.textField.rx.text.orEmpty
            .bind(to: self.viewModel.inputs.searchWord)
            .disposed(by: self.disposeBag)
        
        // リターンキーでキーボードを下げる
        self.textField.rx.controlEvent(.editingDidEndOnExit).asDriver()
            .drive(onNext: { [weak self] _ in
                self?.textField.resignFirstResponder()
            })
            .disposed(by: self.disposeBag)
        
        self.searchButton.rx.tap.asDriver()
            .drive(self.viewModel.inputs.searchTrigger)
            .disposed(by: self.disposeBag)
        
        self.viewModel.outputs.isSearchButtonEnabled
            .asObservable()
            .bind(to: self.searchButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        self.viewModel.outputs.items.asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: "ImageItemCell", cellType: ImageItemCell.self)) { (index, element, cell) in
                cell.configure(URL(string: element.src)!)
            }.disposed(by: self.disposeBag)
        
        self.indicatorView.hidesWhenStopped = true
        self.viewModel.outputs.isLoading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: self.disposeBag)
        
        self.viewModel.outputs.error
            .subscribe(onNext: { [weak self] error in
                let alert = UIAlertController(title: "エラー", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: self.disposeBag)
    }

}


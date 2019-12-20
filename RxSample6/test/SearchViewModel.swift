//
//  SearchViewModel.swift
//  test
//
//  Created by ono on 2019/12/20.
//  Copyright © 2019 ono. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional
import Action
import Kanna

protocol SearchViewModelInputs {
    var searchWord: Variable<String?> { get }
    var searchTrigger: PublishSubject<Void> { get }
}

protocol SearchViewModelOutputs {
    var items: Observable<[Img]> { get }
    var isSearchButtonEnabled: Observable<Bool> { get }
    var isLoading: Observable<Bool> { get }
    var error: Observable<ActionError> { get }
}

protocol SearchViewModelType {
    var inputs: SearchViewModelInputs { get }
    var outputs: SearchViewModelOutputs { get }
}

class SearchViewModel: SearchViewModelType, SearchViewModelInputs, SearchViewModelOutputs {
    
    // Properties
    var inputs: SearchViewModelInputs { return self }
    var outputs: SearchViewModelOutputs { return self }
    
    // Input Sources
    let searchWord = Variable<String?>(nil)
    let searchTrigger = PublishSubject<Void>()
    
    // Output Sources
    let items: Observable<[Img]>
    let isSearchButtonEnabled: Observable<Bool>
    let isLoading: Observable<Bool>
    let error: Observable<ActionError>
    
    private let action: Action<String, [Img]>
    private let disposeBag = DisposeBag()
    
    init() {
        self.action = Action { keyword in
            let urlStr = "https://search.yahoo.co.jp/image/search?n=60&p=\(keyword)"
            let url = URL(string: urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
            
            var request = URLRequest(url: url)
            request.addValue("xxxxx@xxx.com", forHTTPHeaderField: "User-Agent")
            
            return URLSession.shared.rx.response(request: request)
                .filter{ $0.response.statusCode == 200 }
                .map{ $0.data }
                .map{ try! HTML(html: $0 as Data, encoding: .utf8) }
                .map{ $0.css("img").compactMap { $0["src"] }.filter { $0.hasPrefix("https://msp.c.yimg.jp") } }
                .debug("req", trimOutput: false)
                .map{ $0.compactMap{ Img(src:$0) } }
                
            .asObservable()
        }
        
        // ボタンの押下可否
        self.isSearchButtonEnabled = self.searchWord.asObservable()
            .filterNil()
            .map { $0.count >= 3}
        
        // 検索トリガ
        self.searchTrigger.withLatestFrom(self.searchWord.asObservable())
            .filterNil()
            .bind(to: self.action.inputs)
            .disposed(by: self.disposeBag)
        
        // 検索結果
        self.items = self.action.elements
        
        // 処理中か
        self.isLoading = self.action.executing.startWith(false)
        
        // エラー
        self.error = self.action.errors
    }
}

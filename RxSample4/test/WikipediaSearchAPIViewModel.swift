//
//  WikipediaSearchAPIViewModel.swift
//  test
//
//  Created by ono on 2019/12/18.
//  Copyright © 2019 ono. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WikipediaSearchAPIViewModel{
    
    var searchWord = Variable<String>("")
    var items = Variable<[Result]>([])
    
    private let model = WikipediaSearchAPIModel()
    private var disposeBag = DisposeBag()
    
    init() {
        // 検索結果を得てitemsにbind
        searchWord.asObservable()
            .filter { $0.count >= 3 }
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMapLatest { [unowned self] str in
                return self.model.searchWikipedia(["srsearch": str])
            }
            .bind(to: self.items)
            .disposed(by: self.disposeBag)
    }
}

//
//  WikipediaSearchAPIModel.swift
//  test
//
//  Created by ono on 2019/12/18.
//  Copyright © 2019 ono. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WikipediaSearchAPIModel {
    
    let client = WikipediaAPIClient()
    
    // 検索結果をObservableで扱う
    func searchWikipedia(_ parameters: [String:String]) -> Observable<[Result]> {
        
        // [Result]型のObservableオブジェクトを生成
        return Observable<[Result]>.create { (observer) -> Disposable in
            // httpリクエスト
            let request = self.client.getRequest(parameters).responseJSON { response in
                switch response.result {
                case .success(let value):
                    // パースして[Result]に変換
                    let results = self.parseJson(value as? [String:Any] ?? [:])
                    // onNextに渡して完了
                    observer.onNext(results)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
//                // エラー
//                if let error = response.error {
//                    observer.onError(error)
//                }
//                // パースして[Result]に変換
//                let results = self.parseJson(response.result.value as? [String:Any] ?? [:])
//                // onNextに渡して完了
//                observer.onNext(results)
//                observer.onCompleted()
            }
            return Disposables.create { request.cancel() }
        }
    }
    
    // JSON解析
    private func parseJson(_ json: Any) -> [Result] {
        
        guard let items = json as? [String:Any] else { return [] }
        var results = [Result]()
        // 結果を配列で返す
        if let queryItems = items["query"] as? [String:Any] {
            if let searchItems = queryItems["search"] as? [[String:Any]] {
                searchItems.forEach {
                    guard let title = $0["title"] as? String,
                        let pageid = $0["pageid"] as? Int else {
                            return
                    }
                    results.append(Result(title: title, pageid: pageid))
                }
            }
        }
        return results
    }
}

//
//  APIClient.swift
//  test
//
//  Created by ono on 2019/12/18.
//  Copyright © 2019 ono. All rights reserved.
//

import Foundation
import Alamofire

// 共通で利用するプロトコル
protocol APIClient {
    var url: String { get }
    func getRequest(_ prameters: [String:String]) -> DataRequest
}

// Wikipedia APIを呼び出す
class WikipediaAPIClient: APIClient {
    
    var url = "https://ja.wikipedia.org/w/api.php?format=json&action=query&list=search"
    
    func getRequest(_ parameters: [String : String]) -> DataRequest {
        
        return AF.request(URL(string: url)!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
    }
}

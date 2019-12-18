//
//  ViewController.swift
//  test
//
//  Created by ono on 2019/12/18.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private let viewModel = WikipediaSearchAPIViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // searchBarの値とViewModelのSearchWordをbind
        self.searchBar.rx.text.orEmpty
            .bind(to: self.viewModel.searchWord)
            .disposed(by: self.disposeBag)
        
        // 検索結果とtableCellをbind
        self.viewModel.items.asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: "Cell")) { index, result, cell in
                cell.textLabel?.text = result.title
                cell.detailTextLabel?.text = "https://ja.wikipedia.org/w/index.php?curid=\(result.pageid)"
        }
        .disposed(by: self.disposeBag)
    }


}


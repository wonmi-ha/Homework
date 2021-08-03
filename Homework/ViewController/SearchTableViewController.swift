//
//  SearchTableViewController.swift
//  Homework
//
//  Created by 하원미 on 2021/08/02.
//  Copyright © 2021 하원미. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var bookArr: [BookListItemResource] = []
    var page: Int = 0
    var selectIndex = 0
    
    var totalCount = 0
    var oldKeyword = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadBookByKeyword(_ keyword: String) {
        if "" == keyword {
            page = 0
            bookArr.removeAll()
        }
        else {
            page += 1
            if keyword != oldKeyword {
                bookArr.removeAll()
                page = 1
            }
            oldKeyword = keyword
            
            loadBookFromNetwork(keyword, page: page)
        }
    }
    
    func loadBookFromNetwork (_ keyword: String, page: Int) {
        let request = BookListRequest.init(keyword, page: page)
        request.load { (res, error) in
            if error == nil {
                if let res = res {
                    self.totalCount = Int(res.total) ?? 0
                    self.bookArr.append(contentsOf: res.books)
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVc = segue.destination as? BookDetailViewController {
            detailVc.listItem = bookArr[selectIndex]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BookListItemCell", for: indexPath) as? BookListItemCell {
            if bookArr.count > indexPath.row {
                cell.setBookData(bookArr[indexPath.row])
                return cell
            }
        }
        return UITableViewCell.init()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndex = indexPath.row
        performSegue(withIdentifier: SEGUE_ID_SEARCH_TO_DETAIL, sender: self)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == bookArr.count - 2 {
            if self.totalCount / 10 >= page {
                loadBookByKeyword(oldKeyword)
            }
        }
    }
    
}


// MARK: -SearchBar Delegate

extension SearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.loadBookByKeyword(searchBar.text!)
    }
    
}

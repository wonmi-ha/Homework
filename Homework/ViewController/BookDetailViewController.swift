//
//  BookDetailViewController.swift
//  Homework
//
//  Created by 하원미 on 2021/08/02.
//  Copyright © 2021 하원미. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    
    @IBOutlet weak var imageBook: UIImageView!
    
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelAuthors: UILabel!
    @IBOutlet weak var labelPublisher: UILabel!
    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var labelPages: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    
    var listItem: BookListItemResource? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let listItem = listItem {
            let request = BookDetailRequest.init(listItem.isbn13)
            request.load { (res, error) in
                if error == nil {
                    if let res = res {
                        self.labelTitle.text = res.title
                        self.labelSubTitle.text = res.subtitle
                        
                        self.imageBook.loadImage(res.image)
                        
                        self.labelPrice.text = res.price
                        self.labelAuthors.text = res.authors
                        self.labelPublisher.text = res.publisher
                        self.labelLanguage.text = res.language
                        self.labelPages.text = res.pages
                        self.labelYear.text = res.year
                        self.labelRating.text = res.rating
                        self.labelDesc.text = res.desc
                    }
                }
                
            }
        }
    }

}

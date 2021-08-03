//
//  BookListItemCell.swift
//  Homework
//
//  Created by 하원미 on 2021/08/02.
//  Copyright © 2021 하원미. All rights reserved.
//

import UIKit

class BookListItemCell: UITableViewCell {

    @IBOutlet weak var imageThumb: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setBookData(_ bookData: BookListItemResource) {
        self.labelTitle.text = bookData.title
        self.labelSubTitle.text = bookData.subtitle
        self.labelPrice.text = bookData.price
        
        self.imageThumb.image = UIImage.init()
        self.imageThumb.loadImage(bookData.image)
    }

}

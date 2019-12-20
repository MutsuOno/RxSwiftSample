//
//  ImageItemCell.swift
//  test
//
//  Created by ono on 2019/12/20.
//  Copyright © 2019 ono. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(_ url: URL) {
        self.imageView.af_setImage(withURL: url)
    }
}

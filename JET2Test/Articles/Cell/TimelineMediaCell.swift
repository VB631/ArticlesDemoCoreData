//
//  TimelineMediaCell.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import UIKit

class TimelineMediaCell: UICollectionViewCell {
    
    //MARK:- Outlets --------
   @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imgMedia: UIImageView!
    
    override func awakeFromNib() {
        
        if self.imageIndicator != nil {
            self.imageIndicator.isHidden = true }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgMedia.image = UIImage()
         self.imgMedia.image = nil
        if self.imageIndicator != nil {
            self.imageIndicator.isHidden = true }
       
    }
    
      var mediaObject : ArticleMediaModel? {
          didSet {
              guard let mediaObject = mediaObject else {
                  return
              }
            if let image = mediaObject.image {
                self.imageIndicator.isHidden = false
                self.imageIndicator.startAnimating()
                self.imgMedia.image = UIImage()
                self.imgMedia.image = nil
                self.imgMedia.sd_setImage(with: URL(string: image)) { (image, error, cacheType, url) in
                    if error == nil {
                        self.imageIndicator.stopAnimating()
                        self.imageIndicator.isHidden = true
                    }
                }
            }
        }
    }
    
}

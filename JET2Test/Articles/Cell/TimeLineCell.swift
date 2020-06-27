//
//  TimeLineCell.swift
//  JET2Test
//
//  Created by VB PANDEY on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import UIKit

class TimeLineCell: UITableViewCell {
    
    
    //MARK:- ---- outlet -------
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblUserDesignation: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var mediaView: UIView!
    
    @IBOutlet weak var colMedia: UICollectionView!
    
    @IBOutlet weak var lblContent: UILabel!
    
    @IBOutlet weak var lblArticleTitle: UILabel!
    
    @IBOutlet weak var lblArticleUrl: UILabel!
    
    @IBOutlet weak var lblComment: UILabel!
    
    @IBOutlet weak var lblLike: UILabel!
    
    @IBOutlet weak var colMediaHeight: NSLayoutConstraint!
    
    @IBOutlet weak var colMediaBottomHeight: NSLayoutConstraint!
    
    @IBOutlet weak var topHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lblLine: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblDate.text = ""
        self.lblName.text = ""
        self.lblArticleUrl.text = ""
        self.lblArticleTitle.text = ""
        self.lblComment.text = ""
        self.lblContent.text = ""
        self.lblLike.text = ""
        self.lblUserDesignation.text = ""
        mediaView.addCustomBorder(borderColor: Color.cellSeparatorLine, cornerRadius: "5", borderWidth: "1")
        self.lblLine.backgroundColor = Color.cellSeparatorLine.colorWithHexString(hex: Color.cellSeparatorLine)
        self.imgProfile.setSimpleProfileRoundImage()
        self.imgProfile.addBorder(borderColor: Color.cellSeparatorLine, borderWidth: Color.cellSeparatorLine)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var mediaList = [ArticleMediaModel]() {
        didSet {
            colMedia.reloadData()
        }
    }
    
    //-----------------------------------------------------------------------------
    //MARK:- Set data with UI -----------
    //-----------------------------------------------------------------------------
    var articleObject : ArticleModel? {
        didSet {
            guard let articleObject = articleObject else {
                return
            }
            
            self.lblContent.setCustomText(text: articleObject.content, font: Font.SFProTextMedium, size: "13", color: Color.grayColorNew, style: nil)
            
            if articleObject.comments ?? 0 >= 1000 {
                self.lblComment.setCustomText(text: ("\((articleObject.comments ?? 0)/1000)K" + " \("Comments")"), font: Font.SFProTextSemibold, size: "14", color: Color.blackColor, style: nil)
            }
            else {
                self.lblComment.setCustomText(text: ("\(articleObject.comments ?? 0)" + " \("Comments")"), font: Font.SFProTextSemibold, size: "14", color: Color.blackColor, style: nil)
            }
            if articleObject.likes ?? 0 >= 1000 {
                self.lblLike.setCustomText(text: ("\((articleObject.likes ?? 0)/1000)K" + " \("Likes")"), font: Font.SFProTextSemibold, size: "14", color: Color.blackColor, style: nil)
            }
            else {
                self.lblLike.setCustomText(text: ("\(articleObject.likes ?? 0)" + " \("Likes")"), font: Font.SFProTextSemibold, size: "14", color: Color.blackColor, style: nil)
            }
            
            // GET THE FORMATED DATE
            if let time = articleObject.createdAt {
                let formatter = DateFormatter()
                formatter.timeZone = TimeZone.current
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                if let userDate = formatter.date(from: time) {
                    self.lblDate.setCustomText(text: userDate.getElapsedInterval(), font: Font.SFProTextRegular, size: "12", color: Color.grayColor, style: nil)
                }
            }
            
            // GET THE MEDIA LIST DATA
            if articleObject.mediaList.count > 0 {
                colMediaHeight.constant = 200
                colMediaBottomHeight.constant = 20
                topHeight.constant = 15
                colMedia.dataSource = self
                colMedia.delegate = self
                mediaList = articleObject.mediaList
                self.setUpUserMediaData(index:0)
            }
            else {
                self.lblArticleTitle.text = ""
                self.lblArticleUrl.text = ""
                colMediaHeight.constant = 0
                colMediaBottomHeight.constant = 0
                topHeight.constant = -30
            }
            
        }
    }
    
    
}

//-----------------------------------------------------------------------------
//------------ CollectionView DataSouce & Delegate Method ----
//-----------------------------------------------------------------------------
//MARK:- CollectionView Methods --------
extension TimeLineCell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    
    func setupCollectionView() {
        self.colMedia.reloadData()
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return mediaList.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let aCell = self.colMedia.dequeueReusableCell(withReuseIdentifier: "TimelineMediaCell", for: indexPath) as? TimelineMediaCell {
            aCell.mediaObject = self.mediaList[indexPath.item]
            return aCell
        }
            
        else {
            return UICollectionViewCell()
        }
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = (self.colMedia?.contentOffset) ?? CGPoint(x: 0, y: 0)
        visibleRect.size = (self.colMedia?.bounds.size) ?? CGSize(width: self.colMedia?.frame.width ?? 0, height: self.colMedia?.frame.height ?? 0)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = self.colMedia?.indexPathForItem(at: visiblePoint) else { return }
        self.colMedia.reloadItems(at: [indexPath])
        self.colMedia.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.setUpUserMediaData(index:indexPath.row)
        
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.colMedia.frame.width, height:  self.colMedia.frame.height)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return 0
    }
    
    
    
    //-----------------------------------------------------------------------------
    //MARK:- set the user data according post media --------
    //-----------------------------------------------------------------------------
    func setUpUserMediaData(index:Int) {
        
        if let mediaObj = articleObject?.mediaList[index] {
            self.lblArticleTitle.setCustomText(text: mediaObj.title, font: Font.SFProTextRegular, size: "14", color: Color.grayColor, style: nil)
            self.lblArticleUrl.setCustomText(text: mediaObj.url, font: Font.SFProTextRegular, size: "14", color: Color.btnBlueColor, style: nil)
            
            // GET THE USER LIST DATA according to media post
            let userData = articleObject?.userList.filter{$0.blogId == mediaObj.blogId}
            if ((userData?.count ?? 0) > 0) {
                if let userObj = userData?.first {
                    self.lblName.setCustomText(text: userObj.name, font: Font.SFProTextSemibold, size: "14", color: Color.blackColor, style: nil)
                    self.lblUserDesignation.setCustomText(text: userObj.designation, font: Font.SFProTextRegular, size: "16", color: Color.grayColorNew, style: nil)
                    if let profilePic = userObj.avatar {
                        self.imgProfile.sd_setImage(with: URL(string: profilePic), completed: nil)
                    }
                }
            }
        }
        
        
    }
    
}



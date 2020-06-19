//
//  ArticleTableViewCell.swift
//  SampleAppJTT
//
//  Created by Nitz on 18/06/20.
//  Copyright © 2020 JTT. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var heightConstraintArticleImg: NSLayoutConstraint!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserDesignation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var lblArticleContent: UILabel!
    @IBOutlet weak var lblArticleTittle: UILabel!
    @IBOutlet weak var lblArticleUrl: UILabel!
    @IBOutlet weak var lblArticleLikes: UILabel!
    @IBOutlet weak var lblArticleComments: UILabel!
    
    var articlesCell: Articles?
    let articleVM = ArticleViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Mark: Configuring Cell for tableView
    func configCell() {
        
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.lightGray.cgColor
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
        let createdDate = articlesCell?.createdAt?.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        lblTime.text = createdDate?.timeAgoSinceDate()
        lblArticleLikes.text = articleVM.formatNumber(articlesCell?.likes ?? 0) + " Likes"
        lblArticleComments.text = articleVM.formatNumber(articlesCell?.comments ?? 0) + " Comments"
        
        guard !(articlesCell?.user?.isEmpty)! else {
            return
        }
        lblUserName.text = articlesCell?.user?[0].name ?? ""
        lblUserDesignation.text = articlesCell?.user?[0].designation ?? ""
        lblArticleContent.text = articlesCell?.content ?? ""
        if let userImageUrl = articlesCell?.user?[0].avatar {
            let url = URL(string: userImageUrl)
            userImage.kf.setImage(with: url)
        }

        guard !(articlesCell?.media?.isEmpty)! else {
            heightConstraintArticleImg.constant = 0
            return
        }
        heightConstraintArticleImg.constant = 175
        lblArticleTittle.text = articlesCell?.media?[0].title ?? ""
        lblArticleUrl.text = articlesCell?.media?[0].url ?? ""

        if let articleImageUrl = articlesCell?.media?[0].image {
            let url = URL(string: articleImageUrl)
            articleImage.kf.setImage(with: url)
        }
        else{
            heightConstraintArticleImg.constant = 0
        }
    }
}

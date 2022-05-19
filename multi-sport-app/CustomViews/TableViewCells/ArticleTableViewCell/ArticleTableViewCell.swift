//
//  ArticleTableViewCell.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    
    static let identifier = "ArticleTableViewCell"

    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var durationFromNowLabel: UILabel!
    @IBOutlet weak var newsDescLabel: UILabel!
    
    func setup(article: Article) {
        newsImageView.kf.setImage(with: URL(string: article.urlToImage ?? "No image found"))
        durationFromNowLabel.text = "Some duration"
        newsDescLabel.text = article.title ?? "No title found"
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

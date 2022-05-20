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

    
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var durationFromNowLabel: UILabel!
    @IBOutlet weak var newsDescLabel: UILabel!
    
    func setup(article: Article) {
        
        //get the date string from api with format ISO 8601 YYYY-MM-DD`T`HH-mm-ss+Z
        //exclude the locale and timeZone setting
        let date = ISO8601DateFormatter().date(from: article.publishedAt ?? "No valid date found")
        //currDateLabel.text = date?.timeAgo()
        
        newsImageView.kf.setImage(with: URL(string: article.urlToImage ?? "No image found"))
        durationFromNowLabel.text = date?.timeAgo()
        newsDescLabel.text = article.title ?? "No title found"
        publisherLabel.text = article.source?.name ?? ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension Date {
    //display interval between previous date and current date
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full //display abbrev. unit format
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second] //unit to be shown in the output
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1 //max number of unit to be used at a time
        
        //return interval from assigned date to current Date()
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current) + " ago"
    }
}

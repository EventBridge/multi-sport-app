//
//  NewsDetailVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import Kingfisher

class NewsDetailVC: UIViewController {
    
    @IBOutlet weak var newsDetailTitleLabel: UILabel!
    @IBOutlet weak var newsDetailPublisherLabel: UILabel!
    @IBOutlet weak var newsDetailDateTimeLabel: UILabel!
    @IBOutlet weak var newsDetailImage: UIImageView!
    @IBOutlet weak var newsDetailContent: UILabel!
    
    
    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsDetailTitleLabel.text = article?.title ?? "No title found"
        newsDetailPublisherLabel.text = article?.source?.name ?? "No publisher found"
        
        //date from iso8601 string to proper date string
        let date = ISO8601DateFormatter().date(from: article?.publishedAt ?? "No date found")
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short   //eg 4:12PM
        formatter.timeZone = .current
        formatter.locale = .current
        newsDetailDateTimeLabel.text = formatter.string(from: date ?? Date())
        
        newsDetailImage.layer.cornerRadius = 10
        newsDetailImage.kf.setImage(with: URL(string: article?.urlToImage ?? "No image found"))
        newsDetailContent.text = article?.content ?? "No content found"

    }
}

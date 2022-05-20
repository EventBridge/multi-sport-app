//
//  NewsVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import Kingfisher

class NewsVC: UIViewController {
    
    @IBOutlet weak var latestNewsImage: UIImageView!
    @IBOutlet weak var latestNewsDesc: UILabel!
    @IBOutlet weak var currDateLabel: UILabel!
    @IBOutlet weak var newsTableView: UITableView!
    
    
    //var latestArticle = Article
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        //latest news view set corner radius
        latestNewsImage.layer.cornerRadius = 20
        latestNewsDesc.layer.cornerRadius = 20
        latestNewsDesc.layer.masksToBounds = true
        
        //news api //get instantly after load
        NetworkService.shared.fetchArticles(query: "nba", sortBy: "publishedAt", language: "en", domains: "nytimes.com") { [weak self] (result) in
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.newsTableView.reloadData()
                //set up latest article view
                self?.setupLatestNews(article: articles[0])
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
            }
        }
        
        //date format
        let present = Date()    //current date
        let formatter = DateFormatter()
        formatter.dateStyle = .full        //formatter.timeStyle = .short   //show 4:12PM
        formatter.timeZone = .current
        formatter.locale = .current
        currDateLabel.text = formatter.string(from: present) //show current day and date as string


        print(articles)
        
        //register cell
        let nib = UINib(nibName: ArticleTableViewCell.identifier, bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)
    }
    
    //latest news
    func setupLatestNews(article: Article) {
        //let date = ISO8601DateFormatter().date(from: article.publishedAt ?? "No valid date found")
        //currDateLabel.text = date?.timeAgo()
        
        latestNewsImage.kf.setImage(with: URL(string: article.urlToImage ?? "No image found"))
        //durationFromNowLabel.text = date?.timeAgo()
        latestNewsDesc.text = article.title ?? "No title found"
    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as! ArticleTableViewCell
        cell.setup(article: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}



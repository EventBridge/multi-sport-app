//
//  NewsVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var currDateLabel: UILabel!
    @IBOutlet weak var newsTableView: UITableView!
    
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        //date format
        let present = Date()    //current date
        let formatter = DateFormatter()
        formatter.dateStyle = .full        //formatter.timeStyle = .short   //show 4:12PM
        formatter.timeZone = .current
        formatter.locale = .current
        
        currDateLabel.text = formatter.string(from: present) //show current day and date as string
        
        //register cell
        let nib = UINib(nibName: ArticleTableViewCell.identifier, bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        
        //news api
        NetworkService.shared.fetchArticles(query: "nba", sortBy: "publishedAt", language: "en", domains: "espn.com") { [weak self] (result) in
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.newsTableView.reloadData()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
            }
        }
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



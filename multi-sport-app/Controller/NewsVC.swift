//
//  NewsVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import Kingfisher
import ProgressHUD

class NewsVC: UIViewController {
    
    @IBOutlet weak var latestNewsImage: UIImageView!
    @IBOutlet weak var latestNewsDesc: UILabel!
    @IBOutlet weak var currDateLabel: UILabel!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var latestNewsTimeAgo: UILabel!
    @IBOutlet var imageTap: UITapGestureRecognizer!
    @IBOutlet weak var newsSourcePopUp: UIButton!
    
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        //latest news view set corner radius
        latestNewsImage.layer.cornerRadius = 10
        latestNewsDesc.layer.cornerRadius = 10
        latestNewsDesc.layer.masksToBounds = true
        latestNewsTimeAgo.layer.cornerRadius = 10
        latestNewsTimeAgo.layer.masksToBounds = true
        
        
        ProgressHUD.show()
        
        //set up news pop up button (selection)
        setupNewsSourceButton()
        
        
        //news api //get instantly after load
        NetworkService.shared.fetchArticles(query: "nba", sortBy: "publishedAt", language: "en", domains: "espn.com") { [weak self] (result) in
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.newsTableView.reloadData()
                //set up latest article view
                self?.setupLatestNews(article: articles[0])
                self?.latestNewsTimeAgo.isHidden = false
                self?.latestNewsDesc.isHidden = false
                ProgressHUD.dismiss()
                
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
        //set up tap gesture for main image
        let imageTap = UITapGestureRecognizer(target: self,action:#selector(self.imageTapped))
        self.latestNewsImage.isUserInteractionEnabled = true
        self.latestNewsImage.addGestureRecognizer(imageTap)
        
        //date format (current)
        let present = Date()    //current date
        let formatter = DateFormatter()
        formatter.dateStyle = .full        //formatter.timeStyle = .short   //show 4:12PM
        formatter.timeZone = .current
        formatter.locale = .current
        currDateLabel.text = formatter.string(from: present) //show current day and date as string
        
        //register cell
        let nib = UINib(nibName: ArticleTableViewCell.identifier, bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)
    }
    
    //News Source selection menu func
    func setupNewsSourceButton() {
        let optionClosure = {(action: UIAction) in
            print(action.title)
        }
        newsSourcePopUp.menu = UIMenu(children : [
            UIAction(title: "ESPN", state: .on, handler: optionClosure),
            UIAction(title: "New York Times", handler: optionClosure),
            UIAction(title: "NFL", handler: optionClosure),
            UIAction(title: "NBA", handler: optionClosure),
            UIAction(title: "Fox Sports", handler: optionClosure)])
    }
    
    //main news view image tapped func
    @objc func imageTapped() {
        performSegue(withIdentifier: "mainImageToNewsDetail", sender: "")
    }
    
    //latest news set up func
    func setupLatestNews(article: Article) {
        
        let date = ISO8601DateFormatter().date(from: article.publishedAt ?? "No valid date found")
        latestNewsImage.kf.setImage(with: URL(string: article.urlToImage ?? "No image found"))
        latestNewsTimeAgo.text =  " \(date?.timeAgo() ?? "") "   //date extension to get time ago
        latestNewsDesc.text = article.title ?? "No title found"

    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count - 1  //first article is used as main view, so table rolls -1
    }
    
    //setup articles data in cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as! ArticleTableViewCell
        cell.newsImageView.layer.cornerRadius = 5
        cell.setup(article: articles[indexPath.row + 1]) //second article as first in the table view
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0 //set row height
    }
    
    //click a cell and go to news detail page
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNewsDetail", sender: self)
    }
    
    //parse data to new VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? NewsDetailVC
        if segue.identifier == "goToNewsDetail" {
            destination?.article = articles[(newsTableView.indexPathForSelectedRow?.row)! + 1]
            newsTableView.deselectRow(at: newsTableView.indexPathForSelectedRow!, animated: true)
        } else if segue.identifier == "mainImageToNewsDetail" {
            destination?.article = articles[0]
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() //dispose any resources that can be recreated
    }
}



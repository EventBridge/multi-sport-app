//
//  NewsVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var currDateLabel: UILabel!
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //news api
//        NetworkService.shared.fetchArticles(query: "nba") { [weak self] (result) in
//            switch result {
//            case.success(let articles):
//                self?.articles = articles
//                print("The decoded data is:\n \(self?.articles)")
//            case.failure(let error):
//                print("The error is: \(error.localizedDescription)")
//            }
//        }
        
        let present = Date()
        
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "dd/MM/yyyy"
        
        currDateLabel.text = formatter.string(from: present)
        
        
    }
}

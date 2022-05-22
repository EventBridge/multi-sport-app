//
//  MatchDetailVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import Kingfisher

class MatchDetailVC: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var gameTypeNameLabel: UILabel!
    
    @IBOutlet weak var teamHomeLogo: UIImageView!
    @IBOutlet weak var teamHomeName: UILabel!
    @IBOutlet weak var teamHomeScore: UILabel!
    
    @IBOutlet weak var teamVisLogo: UIImageView!
    @IBOutlet weak var teamVisName: UILabel!
    @IBOutlet weak var teamVisScore: UILabel!
    
    @IBOutlet weak var pointsAsigneeLabel: UILabel!
    @IBOutlet weak var arenaLabel: UILabel!
    
    
    
    
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let strDate = game?.date?.start //get string date from api
        
        //iso date string formatter with milliseconds(fractional seconds)
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions.insert(.withFractionalSeconds)
        
        let isoDate = isoFormatter.date(from: strDate ?? "")
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        dateLabel.text = formatter.string(from: isoDate!)
        
        seasonLabel.text = String(game?.season ?? 0)
        gameTypeNameLabel.text = games.
        
    }
}

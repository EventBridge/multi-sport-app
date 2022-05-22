//
//  MatchDetailVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import Kingfisher
import ProgressHUD

class MatchDetailVC: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var gameTypeNameLabel: UILabel!
    
    //team and total score
    @IBOutlet weak var teamHomeLogo: UIImageView!
    @IBOutlet weak var teamHomeName: UILabel!
    @IBOutlet weak var teamHomeScore: UILabel!
    
    @IBOutlet weak var teamVisLogo: UIImageView!
    @IBOutlet weak var teamVisName: UILabel!
    @IBOutlet weak var teamVisScore: UILabel!
    
    //linescore
    @IBOutlet weak var t1s1: UILabel!
    @IBOutlet weak var t1s2: UILabel!
    @IBOutlet weak var t1s3: UILabel!
    @IBOutlet weak var t1s4: UILabel!
    @IBOutlet weak var t1Total: UILabel!
    
    @IBOutlet weak var t2s1: UILabel!
    @IBOutlet weak var t2s2: UILabel!
    @IBOutlet weak var t2s3: UILabel!
    @IBOutlet weak var t2s4: UILabel!
    @IBOutlet weak var t2Total: UILabel!
    
    //officials
    @IBOutlet weak var pointsAsigneeLabel: UILabel!
    
    //arena
    @IBOutlet weak var arenaLabel: UILabel!
    @IBOutlet weak var arenaCity: UILabel!
    @IBOutlet weak var arenaState: UILabel!
    @IBOutlet weak var arenaCountry: UILabel!
    
    //weather
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var chanceOfRain: UILabel!
    @IBOutlet weak var weatherCond: UILabel!
    
    
    let notAvailableImage = "https://previews.123rf.com/images/pe3check/pe3check1710/pe3check171000054/88673746-no-image-available-sign-internet-web-icon-to-indicate-the-absence-of-image-until-it-will-be-download.jpg?fj=1"
    
    var gameTitle: String?
    var game: Game?
    var weather: [Forecast] = []
    var homeCity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let strDate = game?.date?.start //get string date from api
        
        //iso date string formatter with milliseconds(fractional seconds)
        let isoFormat = ISO8601DateFormatter()
        isoFormat.formatOptions.insert(.withFractionalSeconds) //....000Z

        //format to display
        let formatter = DateFormatter()
        formatter.dateStyle = .full

        if isoFormat.date(from: strDate ?? "") != nil {
            // valid format
            let validIsoDate = isoFormat.date(from: strDate ?? "")
            dateLabel.text = formatter.string(from: validIsoDate!)
        } else {
            // invalid format setup
            let invalidIsoFormat = DateFormatter()
            invalidIsoFormat.dateFormat = "yyyy'-'MM'-'dd" //api string date that match this format
            let invalidIsoDate = invalidIsoFormat.date(from: strDate ?? "")
            dateLabel.text = formatter.string(from: invalidIsoDate!)
        }
        
        //home team
        seasonLabel.text = String(game?.season ?? 0)
        gameTypeNameLabel.text = gameTitle ?? ""
        teamHomeLogo.kf.setImage(with: URL(string: game?.teams?.home?.logo ?? notAvailableImage))
        teamHomeName.text = game?.teams?.home?.name
        teamHomeScore.text = String(game?.scores?.home?.points ?? 0)

        //visitor team
        teamVisLogo.kf.setImage(with: URL(string: game?.teams?.visitors?.logo ?? notAvailableImage))
        teamVisName.text = game?.teams?.visitors?.name
        teamVisScore.text = String(game?.scores?.visitors?.points ?? 0)
                
        //linescores
        if game?.scores?.home?.linescore?.count ?? 0 >= 4 {
            t1s1.text = game?.scores?.home?.linescore?[0] ?? "-"
            t1s2.text = game?.scores?.home?.linescore?[1] ?? "-"
            t1s3.text = game?.scores?.home?.linescore?[2] ?? "-"
            t1s4.text = game?.scores?.home?.linescore?[3] ?? "-"
            t1Total.text = String(game?.scores?.home?.points ?? 0)
        } else {
            t1s1.text = "-"
            t1s2.text = "-"
            t1s3.text = "-"
            t1s4.text = "-"
            t1Total.text = "0"
        }
        
        if game?.scores?.visitors?.linescore?.count ?? 0 >= 4 {
            t2s1.text = game?.scores?.visitors?.linescore?[0] ?? "-"
            t2s2.text = game?.scores?.visitors?.linescore?[1] ?? "-"
            t2s3.text = game?.scores?.visitors?.linescore?[2] ?? "-"
            t2s4.text = game?.scores?.visitors?.linescore?[3] ?? "-"
            t2Total.text = String(game?.scores?.visitors?.points ?? 0)
        } else {
            t2s1.text = "-"
            t2s2.text = "-"
            t2s3.text = "-"
            t2s4.text = "-"
            t2Total.text = "0"
        }

        //officials
        let strArr = game?.officials?.joined(separator: ", ")
        pointsAsigneeLabel.text = strArr
        
        //arena
        arenaLabel.text = game?.arena?.name
        arenaCity.text = game?.arena?.city
        arenaState.text = game?.arena?.state
        arenaCountry.text = game?.arena?.country

        let firstWord = game?.teams?.home?.name?.components(separatedBy: " ").first
        
        if game?.teams?.home?.name == "Golden State Warriors" {
            homeCity = "San Francisco"
        } else {
            homeCity = firstWord
        }
        
        //show weather fetch api
        ProgressHUD.show()
        NetworkService.shared.fetchHistory(location: homeCity ?? "", days: "10") { [weak self] (result) in
            switch result {
            case.success(let weather):
                self?.weather = weather
                
                //format to display
                let newformatter = DateFormatter()
                newformatter.dateFormat = "EEEE, MMMM, d, yyyy"
                let newDate = newformatter.date(from: self?.dateLabel.text ?? "") //string to date
                let newf = DateFormatter()
                newf.dateFormat = "yyyy-MM-dd"
                let newStrDate = newf.string(from: newDate!)
                print(newStrDate)
                
                //date weather api "2020-05-22"
                for item in weather {
                    if newStrDate == item.date {
                        self?.maxTemp.text = String(item.max_temp_c ?? 0)
                        self?.minTemp.text = String(item.min_temp_c ?? 0)
                        self?.chanceOfRain.text = String(item.chance_of_rain ?? 0)
                        self?.weatherCond.text = item.condition ?? "N/A"

                    }
                }
                
                
                
                
                ProgressHUD.dismiss()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
        


        
        
    }
}

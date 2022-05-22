//
//  MatchTableViewCell.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 19/5/2022.
//

import UIKit
import Kingfisher

class MatchTableViewCell: UITableViewCell {
    
    let notAvailableImage = "https://previews.123rf.com/images/pe3check/pe3check1710/pe3check171000054/88673746-no-image-available-sign-internet-web-icon-to-indicate-the-absence-of-image-until-it-will-be-download.jpg?fj=1"
    
    static let identifier = "MatchTableViewCell"
    
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var visitorTeamLogo: UIImageView!
    @IBOutlet weak var visitorTeamName: UILabel!
    @IBOutlet weak var visitorTeamScore: UILabel!
    @IBOutlet weak var gameDateDay: UILabel!
    @IBOutlet weak var gameTime: UILabel!
    
    
    func setup(game: Game) {
        gameTitleLabel.text = checkTeamWon(game: game) //display heading with the team won

        homeTeamLogo.kf.setImage(with: URL(string: game.teams?.home?.logo ?? notAvailableImage))
        homeTeamName.text = game.teams?.home?.nickname
        homeTeamScore.text = String(game.scores?.home?.points ?? 0)
        
        visitorTeamLogo.kf.setImage(with: URL(string: game.teams?.visitors?.logo ?? notAvailableImage))
        visitorTeamName.text = game.teams?.visitors?.nickname
        visitorTeamScore.text = String(game.scores?.visitors?.points ?? 0)
        
        
        //get api date string
        let strDate = game.date?.start //string date
        
        //valid ISO8601 format setup
        let isoFormat = ISO8601DateFormatter()
        isoFormat.formatOptions.insert(.withFractionalSeconds) //....000Z

        //format to display
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM, yyyy"

        if isoFormat.date(from: strDate ?? "") != nil {
            // valid format
            let validIsoDate = isoFormat.date(from: strDate ?? "")
            gameDateDay.text = formatter.string(from: validIsoDate!)

            formatter.timeStyle = .short //time format display eg. 4:12PM
            gameTime.text = formatter.string(from: validIsoDate!)
        } else {
            // invalid format setup
            let invalidIsoFormat = DateFormatter()
            invalidIsoFormat.dateFormat = "yyyy'-'MM'-'dd" //api string date that match this format
            let invalidIsoDate = invalidIsoFormat.date(from: strDate ?? "")
            gameDateDay.text = formatter.string(from: invalidIsoDate!)
            gameTime.text = "No time found"
            gameTime.textColor = .systemGray2
        }
    }
    
    //func for display Team1 vs Team2 as heading with an indicator for the team won
    func checkTeamWon(game: Game) -> String{
        var teamWon: String
        
        //guard used to make sure value is not null
        guard let teamHomeScore = game.scores?.home?.points, let teamVisitorsScore = game.scores?.visitors?.points else {
            //value is nil //both team don't have a score
            teamWon = (game.teams?.home?.code)! + " vs " + (game.teams?.visitors?.code)!
            return teamWon
        }
                
        if teamHomeScore > teamVisitorsScore {
            teamWon = (game.teams?.home?.code)! + "(won) vs " + (game.teams?.visitors?.code)!
        } else {
            teamWon = (game.teams?.home?.code)! + " vs " + (game.teams?.visitors?.code)! + "(won)"
        }
        return teamWon
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

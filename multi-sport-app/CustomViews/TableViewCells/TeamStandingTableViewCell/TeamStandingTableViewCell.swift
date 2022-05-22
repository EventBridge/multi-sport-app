//
//  TeamStandingTableViewCell.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 22/5/2022.
//

import UIKit

class TeamStandingTableViewCell: UITableViewCell {
    
    static let identifier = "TeamStandingTableViewCell"
    
    let notAvailableImage = "https://previews.123rf.com/images/pe3check/pe3check1710/pe3check171000054/88673746-no-image-available-sign-internet-web-icon-to-indicate-the-absence-of-image-until-it-will-be-download.jpg?fj=1"

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamWinLabel: UILabel!
    @IBOutlet weak var teamLossLabel: UILabel!
    
    func setup(team: TeamStanding) {
        teamImageView.kf.setImage(with: URL(string: team.team?.logo ?? notAvailableImage))
        teamNameLabel.text = team.team?.name
        teamWinLabel.text = String(team.win?.total ?? 0)
        teamLossLabel.text = String(team.loss?.total ?? 0)
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

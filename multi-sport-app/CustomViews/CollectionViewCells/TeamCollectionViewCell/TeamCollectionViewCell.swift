//
//  TeamCollectionViewCell.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 19/5/2022.
//

import UIKit
import Kingfisher

class TeamCollectionViewCell: UICollectionViewCell {

    static let identifier = "TeamCollectionViewCell"
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    func setup(team: Team) {
        logoImage.kf.setImage(with: URL(string: team.logo ?? "No image found"))
        nameLabel.text = team.name ?? "No name found"
        cityLabel.text = team.city ?? "No city found"
    }

}

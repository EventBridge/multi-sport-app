//
//  PlayerDetailVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit

class PlayerDetailVC: UIViewController {
    
    var player: Player?
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerBirthLabel: UILabel!
    @IBOutlet weak var playerHeightLabel: UILabel!
    @IBOutlet weak var playerWeightLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerImageView.kf.setImage(with: URL(string: player?.notAvailableImage ?? ""))
        playerNameLabel.text = "\(player?.firstname ?? "none") \(player?.lastname ?? "none")"
        playerPositionLabel.text = "Position: \(player?.leagues?.standard?.pos ?? "none")"
        playerBirthLabel.text = "Birth: \(player?.birth?.date ?? "unknown")"
        playerHeightLabel.text = "Height: \(player?.height?.meters ?? "unknown")m"
        playerWeightLabel.text = "Weight: \(player?.weight?.kilograms ?? "unknown")kg"
    }
}

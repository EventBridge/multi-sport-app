//
//  MatchVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import ProgressHUD

class MatchVC: UIViewController {
    
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Comment or uncomment when using, saves me api money
//        ProgressHUD.show()
//        NetworkService.shared.fetchGames(date: "2022-05-18") { [weak self] (result) in
//            switch result {
//            case.success(let games):
//                self?.games = games
//                ProgressHUD.dismiss()
//            case.failure(let error):
//                print("The error is: \(error.localizedDescription)")
//                ProgressHUD.showError(error.localisedDescription)
//            }
//        }
    }
}

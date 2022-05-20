//
//  TableVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import ProgressHUD

class TableVC: UIViewController {
    
    var standings: [TeamStanding] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Comment or uncomment when using, saves me api money
        ProgressHUD.show()
        NetworkService.shared.fetchStandings(season: "2021", league: "standard") { [weak self] (result) in
            switch result {
            case.success(let standings):
                self?.standings = standings
                print("The decoded data is:\n \(self?.standings)")
                ProgressHUD.dismiss()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
}

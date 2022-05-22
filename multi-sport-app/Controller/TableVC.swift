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
    
    var eastStandings: [TeamStanding] = []
    var westStandings: [TeamStanding] = []
    
    var currentStandings: String = "east"
    
    @IBOutlet weak var standingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        standingTableView.dataSource = self
        standingTableView.delegate = self
        
        registerCells()
        
        ProgressHUD.show()
        NetworkService.shared.fetchStandings(season: "2021", league: "standard") { [weak self] (result) in
            switch result {
            case.success(let standings):
                self?.standings = standings
                self?.standings.sort {
                    ($0.conference?.rank!)! < ($1.conference?.rank!)!
                }
                self?.spliceStandings()
                self?.standingTableView.reloadData()
                ProgressHUD.dismiss()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    private func spliceStandings() {
        for item in standings {
            if item.conference?.name == "east" {
                eastStandings.append(item)
            } else {
                westStandings.append(item)
            }
        }
    }
    
    private func registerCells() {
        standingTableView.register(UINib(nibName: TeamStandingTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TeamStandingTableViewCell.identifier)
    }
    
    @IBAction func eastClicked(_ sender: Any) {
        currentStandings = "east"
        standingTableView.reloadData()
    }
    
    @IBAction func westClicked(_ sender: Any) {
        currentStandings = "west"
        standingTableView.reloadData()
    }
}

extension TableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentStandings {
        case "east":
            return eastStandings.count
        case "west":
            return westStandings.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch currentStandings {
        case "east":
            let cell = standingTableView.dequeueReusableCell(withIdentifier: TeamStandingTableViewCell.identifier, for: indexPath) as! TeamStandingTableViewCell
            cell.setup(team: eastStandings[indexPath.row])
            return cell
        case "west":
            let cell = standingTableView.dequeueReusableCell(withIdentifier: TeamStandingTableViewCell.identifier, for: indexPath) as! TeamStandingTableViewCell
            cell.setup(team: westStandings[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0 //set row height
    }
}

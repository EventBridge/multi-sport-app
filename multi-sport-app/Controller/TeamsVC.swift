//
//  TeamsVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import ProgressHUD

class TeamsVC: UIViewController {
    @IBOutlet weak var teamCollectionView: UICollectionView!
    
    var teams: [Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamCollectionView.delegate = self
        teamCollectionView.dataSource = self
        //teamCollectionView.collectionViewLayout = UICollectionViewLayout()
        
        registerCells()
        
        ProgressHUD.show()
        // fetch teams
        NetworkService.shared.fetchTeams { [weak self] (result) in
            switch result {
            case.success(let teams):
                self?.teams = teams
                //print("The decoded data is:\n \(self?.teams)")
                self?.teamCollectionView.reloadData()
                ProgressHUD.dismiss()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
        
    }
    
    private func registerCells() {
        teamCollectionView.register(UINib(nibName: TeamCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TeamCollectionViewCell.identifier)
    }
}

extension TeamsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.identifier, for: indexPath) as! TeamCollectionViewCell
        cell.setup(team: teams[indexPath.row])
        return cell
    }
}

extension TeamsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 200)
    }
}

//
//  MatchVC.swift
//  multi-sport-app
//
//  Created by ubisson on 19/05/2022.
//

import UIKit
import ProgressHUD

class MatchVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var gameTableView: UITableView!
    
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTableView.delegate = self
        gameTableView.dataSource = self

        //get current date from date picker
        let dpFormatter = DateFormatter()
        dpFormatter.dateFormat = "yyyy-MM-dd" //date format to pass into api
        let currentDate = dpFormatter.string(from: Date())
        
        //show games match api
        ProgressHUD.show()
        NetworkService.shared.fetchGames(date: currentDate) { [weak self] (result) in
            switch result {
            case.success(let games):
                self?.games = games
                print(self?.games)

                self?.gameTableView.reloadData()
                ProgressHUD.dismiss()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
        //register cell
        let nib = UINib(nibName: MatchTableViewCell.identifier, bundle: nil)
        gameTableView.register(nib, forCellReuseIdentifier: MatchTableViewCell.identifier)
    }
    
    @IBAction func datePickerTapped(_ sender: Any) {
        //get selected date from date picker
        let newDpFormatter = DateFormatter()
        newDpFormatter.calendar = datePicker.calendar
        newDpFormatter.dateFormat = "yyyy-MM-dd"
        let newDateSelected = newDpFormatter.string(from: datePicker.date)
        
        //reload api fetch
        ProgressHUD.show()
        NetworkService.shared.fetchGames(date: newDateSelected) { [weak self] (result) in
            switch result {
            case.success(let games):
                self?.games = games
                self?.gameTableView.reloadData()
                ProgressHUD.dismiss()
            case.failure(let error):
                print("The error is: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
}

extension MatchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    //setup game matches data in cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gameTableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as! MatchTableViewCell
        cell.setup(game: games[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0 //set row height
    }
    
    //click a cell and go to news detail page
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToMatchDetail", sender: self)
    }
    
    //parse data to game detail VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMatchDetail" {
            let destination = segue.destination as? MatchDetailVC
            destination?.game = games[(gameTableView.indexPathForSelectedRow?.row)!]
            gameTableView.deselectRow(at: gameTableView.indexPathForSelectedRow!, animated: true)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() //dispose any resources that can be recreated
    }
    
    
}

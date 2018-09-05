//
//  ViewController.swift
//  ReUsableTableViewCell
//
//  Created by Mac on 05/09/2018.
//  Copyright © 2018 UmairAFzal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, SampleTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var names = ["Umair", "Afzal", "Ali", "Umer", "Huzaifa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
    }
    
    // MARK: - SampleTableViewCellDelegate
    
    func didTapAcceptButton(cell: SampleTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        print("did tap on row number \(String(describing: indexPath?.row))")
    }
    
    func didTapRejectButton(cell: SampleTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        print("did tap on row number \(String(describing: indexPath?.row))")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SampleTableViewCell.cellForTableView(tableView: tableView)
        cell.setupCell(name: names[indexPath.row])
        return cell
    }
}

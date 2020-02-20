//
//  BarCollectionViewController.swift
//  deBarEmBar
//
//  Created by João on 06/02/20.
//  Copyright © 2020 hbsiscom.hbsis.padawan. All rights reserved.
//

import UIKit
import os.log

//MARK: Properties
private let reuseIdentifier = "Cell"
var bars = [Bar]()

class BarTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bars.count
    }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BarTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BarTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BarTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let bar = bars[indexPath.row]
        
        cell.lblNomeBar.text = bar.nome!
        cell.ImagemBar.image = bar.foto!
        cell.ratingBar.rating = bar.rating!
        
        return cell
    }
    
    //MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "showDetail":
            guard let barDetailViewController = segue.destination as? BarViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedBarCell = sender as? BarTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedBarCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedBar = bars[indexPath.row]
            barDetailViewController.bar = selectedBar
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            bars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    @IBAction func unwindToBarList(sender: UIStoryboardSegue){
    if let sourceViewController = sender.source as? BarViewController, let bar = sourceViewController.bar {
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            // Update an existing bar.
            bars[selectedIndexPath.row] = bar
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        }
        else {
            // Add a new bar.
            let newIndexPath = IndexPath(row: bars.count, section: 0)
            
            bars.append(bar)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        }
    }
    
    @IBAction private func updateBars(){
        bars.sort(by:{$0.nome! < $1.nome!})
        tableView.reloadData()
    }
}

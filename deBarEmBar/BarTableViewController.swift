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
        
        // Load any saved meals, otherwise load sample data.
        if let savedBars = loadBars() {
            bars += savedBars
        }
        else {
            // Load the sample data.
            loadSampleBars()
        }
    }
    
    private func loadSampleBars() {
        let foto1 = UIImage(named: "BarImage1")
        let foto2 = UIImage(named: "BarImage2")
        let foto3 = UIImage(named: "BarImage3")
        let foto4 = UIImage(named: "BarImage4")
        let foto5 = UIImage(named: "BarImage5")
        let foto6 = UIImage(named: "BarImage6")
        
        guard let Bar1 =  Bar(nome: "Bar1", foto: foto1, telefone: "911111111", endereco: "Ribeirão Areia", coordenadaX: 0.0, coordenadaY: 0.0, rating: 5) else {
            fatalError("Unable to instantiate Bar1")
        }
        
        guard let Bar2 =  Bar(nome: "Bar2", foto: foto2, telefone: "922222222", endereco: "Ribeirão Solto", coordenadaX: 0.0, coordenadaY: 0.0, rating: 2) else {
            fatalError("Unable to instantiate Bar2")
        }
        
        guard let Bar3 =  Bar(nome: "Bar3", foto: foto3, telefone: "9333333333", endereco: "Ribeirão Preto", coordenadaX: 0.0, coordenadaY: 0.0, rating: 5) else {
            fatalError("Unable to instantiate Bar3")
        }
        
        guard let Bar4 =  Bar(nome: "Bar4", foto: foto4, telefone: "944444444", endereco: "Testo Alto", coordenadaX: 0.0, coordenadaY: 0.0, rating: 3) else {
            fatalError("Unable to instantiate Bar4")
        }
        
        guard let Bar5 =  Bar(nome: "Bar5", foto: foto5, telefone: "955555555", endereco: "Testo Rega", coordenadaX: 0.0, coordenadaY: 0.0, rating: 4) else {
            fatalError("Unable to instantiate Bar5")
        }
        
        guard let Bar6 =  Bar(nome: "Bar6", foto: foto6, telefone: "966666666", endereco: "Testo Rega2", coordenadaX: 0.0, coordenadaY: 0.0, rating: 5) else {
            fatalError("Unable to instantiate Bar6")
        }
        
        bars += [Bar1, Bar2, Bar3, Bar4, Bar5, Bar6]
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
            saveBars()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    private func saveBars() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(bars, toFile: Bar.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Bars successfully saved.", log: OSLog.default, type: .debug)
            updateBars()
        } else {
            os_log("Failed to save bars...", log: OSLog.default, type: .error)
        }
    }

    private func loadBars() -> [Bar]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar]
    }
    
    @IBAction private func updateBars(){
        bars.sort(by:{$0.nome! < $1.nome!})
        tableView.reloadData()
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
        
        // Save the bars.
        saveBars()
        }
    }
}

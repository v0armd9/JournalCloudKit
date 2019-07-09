//
//  EntriesTableViewController.swift
//  JournalCloudKit
//
//  Created by Darin Marcus Armstrong on 7/8/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.fetchEntries { (success) in
            if success{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.formatDate()

        return cell
    }
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditDetailView" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let destinationVC = segue.destination as? EntryDetailViewController
            let entry = EntryController.shared.entries[indexPath.row]
            destinationVC?.entry = entry
        }
    }
}

//
//  LDTableViewController.swift
//  SingleViewApp
//
//  Created by Laurentiu Dascalu on 5/13/19.
//  Copyright © 2019 Laurentiu Dascalu. All rights reserved.
//

import UIKit

// MARK :- LDTableViewController

class LDTableViewController: UITableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
}

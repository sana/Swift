//
//  MyUITableViewDataSource.swift
//  SimpleTableView
//
//  Created by Laurentiu Dascalu on 2/6/21.
//  Copyright © 2021 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import UIKit

protocol MyUITableViewDataSource /* UITableViewDataSource */ {
    func numberOfSections() -> Int
    func cell(atIndexPath indexPath: IndexPath) -> UITableViewCell
}

class SimpleMyUITableViewDataSource : MyUITableViewDataSource {
    func numberOfSections() -> Int {
        return 100
    }

    func cell(atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "SimpleMyUITableViewDataSource")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

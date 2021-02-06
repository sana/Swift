//
//  MyUITableView.swift
//  SimpleTableView
//
//  Created by Laurentiu Dascalu on 2/6/21.
//  Copyright © 2021 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import UIKit

class MyUITableView : UIScrollView /* UITableView */ {
    let cellHeight: CGFloat = 44
    let dataSource : MyUITableViewDataSource = SimpleMyUITableViewDataSource()
    var cells = [UITableViewCell]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let yOffset = contentOffset.y
        let adjustedYOffset = (yOffset >= 0) ? yOffset : 0

        let firstCellTag = Int(ceil(adjustedYOffset / cellHeight))

        guard
            let firstCell = cells.first,
            firstCell.tag != firstCellTag
        else
        {
            return
        }

        if firstCellTag > firstCell.tag {
            guard
                let lastCell = cells.last,
                lastCell.tag + 1 < dataSource.numberOfSections()
            else {
                return
            }

            let newIndex = lastCell.tag + 1
            let cell = dataSource.cell(atIndexPath: IndexPath(row: newIndex, section: 0))
            cell.frame = CGRect(x: 0, y: CGFloat(newIndex) * cellHeight, width: frame.width, height: cellHeight)
            cell.tag = newIndex
            cells.remove(at: 0).removeFromSuperview()
            cells.append(cell)
            addSubview(cell)
        } else {
            guard
                let firstCell = cells.first,
                firstCell.tag > 0
            else {
                return
            }

            let newIndex = firstCell.tag - 1
            let cell = dataSource.cell(atIndexPath: IndexPath(row: newIndex, section: 0))
            cell.frame = CGRect(x: 0, y: CGFloat(newIndex) * cellHeight, width: frame.width, height: cellHeight)
            cell.tag = newIndex
            cells.insert(cell, at: 0)
            cells.popLast()?.removeFromSuperview()
            addSubview(cell)
        }
    }

    override var frame: CGRect {
        didSet {
            let contentHeight: CGFloat = CGFloat(dataSource.numberOfSections()) * cellHeight
            contentSize = CGSize(width: frame.width, height: contentHeight)

            // Remove the old cells
            cells.forEach { $0.removeFromSuperview() }

            // Recreate the cells this UIScrollView manages
            let availableHeight = frame.height - adjustedContentInset.top - adjustedContentInset.bottom
            cells = [UITableViewCell]()
            let availableCells = Int(ceil(availableHeight / cellHeight))
            for i in 0..<availableCells {
                let cell = dataSource.cell(atIndexPath: IndexPath(row: i, section: 0))
                cell.frame = CGRect(x: 0, y: CGFloat(i) * cellHeight, width: frame.width, height: cellHeight)
                cell.tag = i
                cells.append(cell)
                addSubview(cell)
            }

            setNeedsLayout()
        }
    }
}

extension MyUITableView : UIScrollViewDelegate { }

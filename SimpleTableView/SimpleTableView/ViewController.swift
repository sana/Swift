//
//  ViewController.swift
//  SimpleTableView
//
//  Created by Laurentiu Dascalu on 7/9/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import UIKit

protocol MyUITableViewDataSource /* UITableViewDataSource */ {
    func numberOfSections() -> Int
    func cell(atIndexPath indexPath: IndexPath) -> UITableViewCell
}

class SimpleMyUITableViewDataSource : MyUITableViewDataSource {
    func numberOfSections() -> Int {
        return 1000
    }

    func cell(atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "SimpleMyUITableViewDataSource")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

class MyUITableView : UIScrollView /* UITableView */ {
    let cellHeight: CGFloat = 44
    let dataSource : MyUITableViewDataSource = SimpleMyUITableViewDataSource()
    var cells = [UITableViewCell]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let yOffset = self.contentOffset.y + self.adjustedContentInset.top

        guard yOffset >= 0 else {
            return
        }

        // How many cells are scrolled offscreen
        let firstCellTag = Int(ceil(yOffset / cellHeight))

        // Update the cells' frame and the underlying text
        for i in 0..<cells.count {
            let cell = cells[i]
            cell.frame = CGRect(x: 0, y: CGFloat(i + firstCellTag) * cellHeight, width: self.frame.width, height: cellHeight)
            cell.textLabel?.text = "\(firstCellTag + i)"
        }
    }

    func setup() {
        self.delegate = self
        let contentHeight: CGFloat = CGFloat(dataSource.numberOfSections()) * cellHeight
        self.contentSize = CGSize(width: self.frame.width, height: contentHeight)
    }

    override var frame: CGRect {
        didSet {
            // Once we know the frame, we want to create the cells this UIScrollView manages
            let cellsCount = Int(ceil(self.frame.height / cellHeight))
            for cell in self.cells {
                cell.removeFromSuperview()
            }
            self.cells = [UITableViewCell]()
            for i in 0..<cellsCount + 2 {
                let cell = dataSource.cell(atIndexPath: IndexPath(row: i, section: 0))
                self.cells.append(cell)
                self.addSubview(cell)
            }
            self.setNeedsLayout()
        }
    }
}

extension MyUITableView : UIScrollViewDelegate { }

class ViewController: UIViewController {
    private var myUITableView: MyUITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myUITableView = MyUITableView()
        if let myUITableView = self.myUITableView {
            self.view.addSubview(myUITableView)
            myUITableView.frame = self.view.frame
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


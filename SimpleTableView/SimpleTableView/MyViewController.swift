//
//  MyViewController.swift
//  SimpleTableView
//
//  Created by Laurentiu Dascalu on 7/9/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    private let myUITableView: MyUITableView

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        myUITableView = MyUITableView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(myUITableView)
        myUITableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myUITableView.frame = self.view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//
//  MobileListViewController.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 5/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit

class MobileListViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    
    private var vm: MobileListViewModel!
    
    func setViewModel(_ vm:MobileListViewModel) {
        self.vm = vm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


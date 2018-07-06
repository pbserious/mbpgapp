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
        
        setUpTableView()
        
        vm.dataChangedHandler = { [weak self] in
            self?.tableView.reloadData()
        }
        vm.loadData()
    }
    
    func setUpTableView() {
        tableView.register(UINib(nibName: MobileListCell.nibName, bundle: nil),
                           forCellReuseIdentifier: MobileListCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
}

extension MobileListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfMobileData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MobileListCell.reuseIdentifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? MobileListCell {
            let data = vm.mobileData(for: indexPath)
            cell.setData(data)
        }
    }
}
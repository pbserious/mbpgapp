//
//  MobileListViewController.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 5/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit

class MobileListViewController: UIViewController {

    @IBOutlet fileprivate weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    private var vm: MobileListViewModel!
    
    func setViewModel(_ vm:MobileListViewModel) {
        self.vm = vm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
        
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
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @objc func segmentedControlDidChange() {
        print(segmentedControl.selectedIndex)
    }
}

extension MobileListViewController {
    @IBAction func showSortingSelection() {
        let alert = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
        let options:[MobileListViewModel.Sorting] = vm.sortingOptions()
        options.forEach { [weak self] option in
            alert.addAction(UIAlertAction(title: option.title, style: .default, handler: { _ in
                self?.vm.selectSorting(option)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

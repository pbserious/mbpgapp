//
//  MobileListViewController.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 5/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit

class MobileListViewController: UIViewController {

    enum Segment: Int {
        case all = 0
        case favourite = 1
        
        var title: String {
            switch self {
            case .all:
                return "All"
            case .favourite:
                return "Favourite"
            }
        }
        
        var filtering: MobileListViewModel.Filtering {
            switch self {
            case .all:
                return .none
            case .favourite:
                return .favourite
            }
        }
    }
    
    @IBOutlet fileprivate weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    private var vm: MobileListViewModel!
    
    func setViewModel(_ vm:MobileListViewModel) {
        self.vm = vm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSegmentedControl()
        
        vm.dataChangedHandler = { [weak self] in
            self?.tableView.reloadData()
        }
        vm.loadData()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: MobileListCell.nibName, bundle: nil),
                           forCellReuseIdentifier: MobileListCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func setupSegmentedControl() {
        segmentedControl.items = [Segment.all.title, Segment.favourite.title]
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
    }
    
    @objc func segmentedControlDidChange() {
        guard let segment = Segment(rawValue: segmentedControl.selectedIndex) else { return }
        vm.seletFiltering(segment.filtering)
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

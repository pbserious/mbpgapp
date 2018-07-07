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
    var currentSegment: Segment? {
        return Segment(rawValue: segmentedControl.selectedIndex)
    }
    
    func setViewModel(_ vm:MobileListViewModel) {
        self.vm = vm
        vm.dataChangedHandler = { [weak self] in
            // Reload section with hard code IndexSet
            self?.tableView.reloadSections([0], with: .automatic)
        }
        vm.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = " "
        setupTableView()
        setupSegmentedControl()
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
        guard let segment = currentSegment else { return }
        vm.selectFiltering(segment.filtering)
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
            let data = vm.mobileListCellViewModel(for: indexPath)
            cell.setViewModel(data)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let segment = currentSegment, segment == .favourite else {
            return []
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "Remove") { (action, indexPath) in
            if let cell = tableView.cellForRow(at: indexPath) as? MobileListCell {
                cell.favouritePressed()
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let md = vm.mobileListCellViewModel(for: indexPath).mobileData else { return }
        let destVM = MobileDetailViewModel(uc: MobileInfoUseCase.shared, md: md)
        let destVC = MobileDetailViewController.newInstance
        destVC.setViewModel(destVM)
        
        self.navigationController?.pushViewController(destVC, animated: true)
        
    }
}

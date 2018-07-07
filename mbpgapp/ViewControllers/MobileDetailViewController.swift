//
//  MobileDetailPage.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 7/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit

class MobileDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollableImagesView: HorizontalScrollableImagesView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    fileprivate var vm: MobileDetailViewModel!
    
    static var newInstance: MobileDetailViewController {
        return UIStoryboard(name: "Detail",
                            bundle: nil).instantiateInitialViewController() as! MobileDetailViewController
    }
    
    func setViewModel(_ vm:MobileDetailViewModel) {
        self.vm = vm
        vm.loadingHandler = { [weak self] in
            self?.scrollableImagesView.showLoadingView()
        }
        vm.dataChangedHandler = { [weak self] in
            self?.scrollableImagesView.hideLoadingView()
            self?.setupImages()
        }
    }
    
    func setupView() {
        self.title = vm.getViewTitle()
        self.descriptionTextView.text = vm.getViewDescription()
        self.priceLabel.text = vm.getPrice()
        self.ratingLabel.text = vm.getRating()
    }
    
    func setupImages() {
        scrollableImagesView.imageUrlList = vm.getImageUrlList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        vm.fetchImageList()
    }
}

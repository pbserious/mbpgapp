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
    
    fileprivate var vm: MobileDetailViewModel!
    
    static var newInstance: MobileDetailViewController {
        return UIStoryboard(name: "Detail",
                            bundle: nil).instantiateInitialViewController() as! MobileDetailViewController
    }
    
    func setViewModel(_ vm:MobileDetailViewModel) {
        self.vm = vm
        vm.dataChangedHandler = { [weak self] in
            self?.setupImages()
        }
        vm.fetchImageList()
    }
    
    func setupView() {
        self.title = vm.getViewTitle()
        self.descriptionTextView.text = vm.getViewDescription()
    }
    
    func setupImages() {
        scrollableImagesView.imageUrlList = vm.getImageUrlList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupImages() // first time bring thumb to show
    }
}

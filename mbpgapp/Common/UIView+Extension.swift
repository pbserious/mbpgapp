//
//  UIView+Extension.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 7/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit

extension UIView {
    static let LOADING_VIEW_TAG = 99
    
    func getLoadingView() -> UIView? {
        return self.subviews.first(where: { $0.tag == UIView.LOADING_VIEW_TAG })
    }
    
    func showLoadingView() {
        guard let loadingView = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)![0] as? UIView,
            getLoadingView() == nil else {
            return
        }
        loadingView.frame = self.bounds
        loadingView.tag = UIView.LOADING_VIEW_TAG
        self.addSubview(loadingView)
    }
    
    func hideLoadingView() {
        guard let loadingView = getLoadingView() else {
            return
        }
        UIView.animate(withDuration: 0.3, animations: {
            loadingView.alpha = 0.0
        }) { _ in
            loadingView.isHidden = true
            loadingView.removeFromSuperview()
        }
    }
}

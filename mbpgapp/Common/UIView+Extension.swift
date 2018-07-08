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
    static let EMPTY_VIEW_TAG = 66
    
    func getView(with tag:Int) -> UIView? {
        return self.subviews.first(where: { $0.tag == tag })
    }
    
    func showLoadingView() {
        guard let loadingView = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)![0] as? UIView,
            getView(with: UIView.LOADING_VIEW_TAG) == nil else {
            return
        }
        loadingView.frame = self.bounds
        loadingView.tag = UIView.LOADING_VIEW_TAG
        self.addSubview(loadingView)
    }
    
    func hideLoadingView() {
        hideView(with: UIView.LOADING_VIEW_TAG)
    }
    
    func showEmptyView() {
        guard getView(with: UIView.EMPTY_VIEW_TAG) == nil else {
            return
        }
        let label = UILabel(frame: self.bounds)
        label.textAlignment = .center
        label.text = "There is no content."
        label.tag = UIView.EMPTY_VIEW_TAG
        self.addSubview(label)
    }
    
    func hideEmptyView() {
        hideView(with: UIView.EMPTY_VIEW_TAG)
    }
    
    private func hideView(with tag:Int) {
        guard let view = getView(with: tag) else {
            return
        }
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        }) { _ in
            view.isHidden = true
            view.removeFromSuperview()
        }
    }
}

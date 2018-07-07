//
//  CustomSegmentedControl.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 7/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit

@IBDesignable class CustomSegmentedControl: UIControl {
    
    private var labels = [UILabel]()
    
    @IBInspectable var textColor:UIColor = .gray {
        didSet {
            updateSelectedItem()
        }
    }
    @IBInspectable var selectedTextColor:UIColor = .red  {
        didSet {
            updateSelectedItem()
        }
    }
    
    var items:[String] = ["item1", "item2"] {
        didSet {
            setupView()
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            updateSelectedItem()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let refFrame = self.bounds
        let labelWidth = refFrame.width/CGFloat(labels.count)
        let labelHeight = refFrame.height
        
        for index in 0...labels.count-1 {
            let label = labels[index]
            
            let xPos = CGFloat(index) * labelWidth
            label.frame = CGRect(x: xPos, y: 0,
                                 width: labelWidth, height: labelHeight)
        }
    }
    
    func setupView() {
        setupLabels()
        updateSelectedItem()
    }
    
    func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        
        for index in 1...items.count {
            let label = UILabel(frame: CGRect.zero)
            label.text = items[index-1]
            label.textAlignment = .center
            label.textColor = textColor
            label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    func updateSelectedItem() {
        labels.forEach({ $0.textColor = textColor })
        let label = labels[selectedIndex]
        label.textColor = selectedTextColor
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        var estIndex: Int?
        for (index, label) in labels.enumerated() {
            if label.frame.contains(location) {
                estIndex = index
                break
            }
        }
        
        if let estIndex = estIndex, estIndex != self.selectedIndex {
            self.selectedIndex = estIndex
            self.sendActions(for: .valueChanged)
        }
        
        return false
    }
}


//
//  HorizantalScrollableImagesView.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 7/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit
import Kingfisher

@IBDesignable class HorizontalScrollableImagesView: UIView {
    
    var collectionView: UICollectionView!
    var imageUrlList = [URL]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()

        flowLayout.itemSize = CGSize(width: self.bounds.height, height: self.bounds.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        self.collectionView = UICollectionView(frame: self.bounds,
                                               collectionViewLayout: flowLayout)
        self.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: MobileImageCollectionCell.nibName,
                                           bundle: nil),
                                     forCellWithReuseIdentifier: MobileImageCollectionCell.reuseIdentifier)
    }
}

extension HorizontalScrollableImagesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrlList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MobileImageCollectionCell.reuseIdentifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? MobileImageCollectionCell {
            let url = imageUrlList[indexPath.row]
            cell.imageView.kf.setImage(with: url)
        }
    }
}

//
//  UsersCollectionViewContainer.swift
//  kefa
//
//  Created by Pietro Santececca on 03/07/2017.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit

class UsersCollectionViewContainer: UIView {
    
    // Constants
    let collectionViewHeigth: CGFloat = 80
    let collectionViewSpacing: CGFloat = 0
    let collectionViewCellLeftRightMargins: CGFloat = 10
    let collectionViewCellTopBottomMargins: CGFloat = 5
    let collectionViewCellRatio: CGFloat = 0.8
    let userCollectionViewCellIdentifier = "UsersCollectionViewCell"
    let userCollectionViewCellNib = "UsersCollectionViewCell"
    static let userCollectionViewNib = "UsersCollectionViewContainer"
    
    // Outlets
    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        usersCollectionView.register(UINib(nibName: userCollectionViewCellNib, bundle: nil), forCellWithReuseIdentifier: userCollectionViewCellIdentifier)
        usersCollectionView.delegate = self
        usersCollectionView.dataSource = self
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: userCollectionViewNib, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}


// MARK: - Users Collection View Delegate

extension UsersCollectionViewContainer: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //...
    }
}


// MARK: - Users Collection View Data Scource

extension UsersCollectionViewContainer: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userCollectionViewCellIdentifier, for: indexPath as IndexPath) as! UsersCollectionViewCell
        return cell
    }
}


// MARK: - Users Collection View FlowLayout Delegate

extension UsersCollectionViewContainer: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight: CGFloat = collectionViewHeigth - (collectionViewCellTopBottomMargins * 2)
        let cellWidth: CGFloat = cellHeight * collectionViewCellRatio
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionViewCellTopBottomMargins, left: collectionViewCellLeftRightMargins, bottom: collectionViewCellTopBottomMargins, right: collectionViewCellLeftRightMargins)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewSpacing
    }
}






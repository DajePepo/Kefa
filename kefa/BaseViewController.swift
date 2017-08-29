//
//  BaseViewController.swift
//  kefa
//
//  Created by Pietro Santececca on 29/06/2017.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // Variables
    var usersCollectionViewContainer: UsersCollectionViewContainer?
    var userNavigationItemView: UserNavigationItemView?
    var usersCollectionViewConstraint: NSLayoutConstraint?
    var grayCoverView: UIView?
    var showUserNavigationItem: Bool = false {
        didSet {
            if showUserNavigationItem { addUserInfoIntoNavBar() }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func addUserInfoIntoNavBar() {
        
        // Navigation Item View
        if let userNavigationItemView = UINib(nibName: String(describing: type(of: UserNavigationItemView())), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UserNavigationItemView {
            self.userNavigationItemView = userNavigationItemView
            let gesture = UITapGestureRecognizer(target: self, action: #selector(navigationItemDidTap))
            userNavigationItemView.addGestureRecognizer(gesture)
            userNavigationItemView.isUserInteractionEnabled = true
            self.navigationItem.titleView = userNavigationItemView
        }
    }
    
    func navigationItemDidTap(){
        guard let userNavigationItemView = userNavigationItemView else { return }
        userNavigationItemView.isSelected = !userNavigationItemView.isSelected
        showHideUsersCollectionView(show: userNavigationItemView.isSelected)
    }
    
    func showHideUsersCollectionView(show: Bool) {
        
        if grayCoverView == nil {
            grayCoverView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            grayCoverView!.alpha = 0
            grayCoverView!.backgroundColor = UIColor.black
        }
        
        if usersCollectionViewContainer == nil {
            if let usersCollectionViewContainer = UsersCollectionViewContainer.instanceFromNib() as? UsersCollectionViewContainer {
                self.usersCollectionViewContainer = usersCollectionViewContainer
                self.view.addSubview(usersCollectionViewContainer)
                usersCollectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
                usersCollectionViewContainer.heightAnchor.constraint(equalToConstant: usersCollectionViewContainer.collectionViewHeigth).isActive = true
                usersCollectionViewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                usersCollectionViewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                usersCollectionViewConstraint = usersCollectionViewContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -usersCollectionViewContainer.collectionViewHeigth)
                usersCollectionViewConstraint!.isActive = true
                self.view.layoutIfNeeded()
            }
        }
        
        guard let usersCollectionViewConstraint = usersCollectionViewConstraint,
              let usersCollectionViewContainer = usersCollectionViewContainer,
              let grayCoverView = grayCoverView else { return }
        
        usersCollectionViewConstraint.constant = show ? 0 : -usersCollectionViewContainer.collectionViewHeigth
        if show { self.view.insertSubview(grayCoverView, belowSubview: usersCollectionViewContainer) }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            grayCoverView.alpha = show ? 0.5: 0
        }) { _ in
            if !show { grayCoverView.removeFromSuperview() }
        }
    }
}

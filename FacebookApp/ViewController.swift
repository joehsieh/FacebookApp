//
//  ViewController.swift
//  FacebookApp
//
//  Created by joehsieh on 2016/8/15.
//  Copyright © 2016年 NJ. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate {

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        navigationItem.title = "Facebook Feed"
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.cellIdentifier)
        collectionView?.backgroundColor = UIColor.lightGray
        collectionView?.alwaysBounceVertical = true
        for _ in 0 ..< 100 {
            posts.append(Post())
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.cellIdentifier, for: indexPath) as! FeedCell
        cell.post = posts[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let post = posts[indexPath.item]
        let height = FeedCell.cellHeight(withText: post.statusText, width: self.view.frame.size.width, fontSize: 14)
        return CGSize(width: view.frame.width, height: height)
    }
}

extension ViewController: FeedCellDelegate {
    // MARK: FeedCellDelegate
    
    func didSelectActionButton(sender: FeedCell, actionButton: UIButton) {
        let vc = NJActionItemListViewController()
        vc.modalPresentationStyle = .popover
        let popOverPresentationController = vc.popoverPresentationController
        popOverPresentationController?.delegate = self
        popOverPresentationController?.permittedArrowDirections = [.up, .down]
        popOverPresentationController?.sourceView = actionButton
        popOverPresentationController?.sourceRect = actionButton.bounds
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    @objc(adaptivePresentationStyleForPresentationController:) public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .none
    }

}


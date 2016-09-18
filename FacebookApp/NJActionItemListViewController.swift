//
//  NJActionItemListViewController.swift
//  FacebookApp
//
//  Created by joehsieh on 2016/9/14.
//  Copyright © 2016年 NJ. All rights reserved.
//

import Foundation
import UIKit

// The minimum height of the cell is 44.0
let kActionItemIconNameKey = "imageName"
let kActionItemTitleNameKey = "title"
let kActionItemSubtitlNameKey = "subtitle"

class NJActionItemCell: UICollectionViewCell
{
    static let cellIdentifier = NSStringFromClass(NJActionItemCell.self)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func cellHeight() -> CGFloat{
        return 44.0
    }
    
    //MARK: Properties
    var userInfo: [String: String]? {
        didSet {
            if let imageName = userInfo?[kActionItemIconNameKey] {
                iconView.image = UIImage(named: imageName)
            }
            if let title = userInfo?[kActionItemTitleNameKey] {
                titleLabel.text = title
            }
            if let subtitle = userInfo?[kActionItemSubtitlNameKey] {
                subtitleLabel.text = subtitle
            }
        }
    }
    let iconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
        }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    //MARK: Private methods
    
    func setupViews() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.lightGray
        self.selectedBackgroundView = selectedBackgroundView
        
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subtitleLabel)
        let iconViewHeight: CGFloat = 24.0
        let iconViewTopSapce = (NJActionItemCell.cellHeight() - iconViewHeight) / 2.0
        self.contentView.addConstraintsWithFormat(format: "V:|-\(iconViewTopSapce)-[v0(\(iconViewHeight))]", views: iconView)
        self.contentView.addConstraintsWithFormat(format: "H:[v0(\(iconViewHeight))]", views: iconView)
        self.contentView.addConstraintsWithFormat(format: "H:|-20-[v0]-20-[v1]-20-|", views: iconView, titleLabel)
        self.contentView.addConstraintsWithFormat(format: "H:|-20-[v0]-20-[v1]-20-|", views: iconView, subtitleLabel)
        self.contentView.addConstraintsWithFormat(format: "V:|[v0]-0-[v1]|", views: titleLabel, subtitleLabel)
    }
}

class NJActionItemListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width, height: NJActionItemCell.cellHeight() * 5)
    }
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0.0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    // MARK: Private method
    
    func setupViews() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(NJActionItemCell.self, forCellWithReuseIdentifier: NJActionItemCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: Properties
    let titles: Array = {
        return ["Save post", "Hide post", "Unfollow post", "Report this post", "Turn on notifications for this post"]
    }()
    let subtitles: Array = {
        return ["Add link to your saved links", "See fewer posts like this", "Stop seeing posts but stay friends", "", ""]
    }()
    let imageNames: Array = {
        return ["like", "like", "like", "like", "like"]
    }()
    
    // MARK: UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NJActionItemCell.cellIdentifier, for: indexPath) as! NJActionItemCell
        let index = indexPath.item
        cell.userInfo = [kActionItemIconNameKey: imageNames[index], kActionItemTitleNameKey: titles[index], kActionItemSubtitlNameKey: subtitles[index]]
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: NJActionItemCell.cellHeight())
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

//
//  ViewController.swift
//  FacebookApp
//
//  Created by joehsieh on 2016/8/15.
//  Copyright © 2016年 NJ. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat  = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 0.4 + 44
        let post = posts[indexPath.item]
        let textRect = post.statusText.boundingRect(with: CGSize(width: self.view.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
        height += textRect.height
        return CGSize(width: view.frame.width, height: ceil(height))
    }
}

class FeedCell: UICollectionViewCell
{
    static let cellIdentifier = NSStringFromClass(FeedCell.self)
    
    var post: Post? {
        didSet {
            
            if let name = post?.name {
                
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
                
                attributedText.append(NSAttributedString(string: "\nDecember 18  •  San Francisco  •  ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName:
                    UIColor.rgb(red: 155, green: 161, blue: 161)]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
                
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "globe_small")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
                
                nameLabel.attributedText = attributedText
                
            }
            
            if let statusText = post?.statusText {
                statusLabel.text = statusText
            }
            
            if let profileImagename = post?.profileImageName {
                profileImageView.image = UIImage(named: profileImagename)
            }
            
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot call this method")
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "Mark Zuckerberg", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\nDecember 18 San Francisco", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.rgb(red: 155, green: 161, blue: 171)]))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        label.attributedText = attributedText
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Meanwhile. Beast turned to the dark side."
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "488 Likes   10.7K Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    let likeButton = FeedCell.button(for: "Like", imageName: "like")
    let commentButton = FeedCell.button(for: "Comment", imageName: "comment")
    let shareButton = FeedCell.button(for: "Share", imageName: "share")
    
    static func button(for title:String, imageName:String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(named:imageName), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 0.0)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        return button
    }
    
    func setupViews() {
        backgroundColor = UIColor.white
        contentView.addSubview(nameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusImageView)
        contentView.addSubview(likesCommentsLabel)
        contentView.addSubview(dividerLineView)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView, statusLabel, statusImageView, likesCommentsLabel, dividerLineView, likeButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

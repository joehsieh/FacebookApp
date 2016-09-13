//
//  FeedCell.swift
//  FacebookApp
//
//  Created by joehsieh on 2016/8/24.
//  Copyright © 2016年 NJ. All rights reserved.
//

import UIKit
import WebImage

class FeedCell: UICollectionViewCell, SDWebImageManagerDelegate
{
    static let cellIdentifier = NSStringFromClass(FeedCell.self)
    static let imageHeight: CGFloat = 200.0
    static let imageRootURL = "https://source.unsplash.com/random"
    static let avatarImageHeight: CGFloat = 44.0
    static let imageSizeString = "\(Int(UIScreen.main.bounds.size.width))x\(Int(imageHeight))"
    static let avatarImageSizeString = "\(Int(avatarImageHeight))x\(Int(avatarImageHeight))"
    
    static func cellHeight(withText:String, width: CGFloat, fontSize: CGFloat) -> CGFloat{
        var height: CGFloat  = 8 + avatarImageHeight + 4 + 4 + imageHeight + 8 + 24 + 8 + 0.4 + 44
        let textRect = withText.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
        height += textRect.height
        return ceil(height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    // MARK: properties
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
            
            if let avatarImagename = post?.avatarImageName {
                avatarImageView.sd_setImage(with: URL(string: "\(FeedCell.imageRootURL)/\(FeedCell.avatarImageSizeString)?a=\(avatarImagename)"), placeholderImage: UIImage(named:"placeholder"), options: .retryFailed, completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, url: URL?) in
                    if error != nil {
                        return
                    }
                })
            }
            
            if let identifier = post?.identifier {
                statusImageView.sd_setImage(with: URL(string: "\(FeedCell.imageRootURL)/\(FeedCell.imageSizeString)?a=\(identifier)"), placeholderImage: UIImage(named:"placeholder"), options: .retryFailed, completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, url: URL?) in
                    if error != nil {
                        return
                    }
                })
            }
            
        }
    }
    
    deinit {
        SDWebImageManager.shared().delegate = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        SDWebImageManager.shared().delegate = self
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
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
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"downArrow"), for: .normal)
        return button
    }()
    
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
        contentView.addSubview(avatarImageView)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusImageView)
        contentView.addSubview(likesCommentsLabel)
        contentView.addSubview(dividerLineView)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(clickActionButton(sender:)), for: .touchUpInside)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: avatarImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: avatarImageView, statusLabel, statusImageView, likesCommentsLabel, dividerLineView, likeButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        addConstraintsWithFormat(format: "V:|-12-[v0(44)]", views: actionButton)
        addConstraintsWithFormat(format: "H:[v0]-12-|", views: actionButton)
        
    }
    
    // MARK: SDWebImageManagerDelegate
    
    func imageManager(_ imageManager: SDWebImageManager!, transformDownloadedImage image: UIImage!, with imageURL: URL!) -> UIImage! {
        guard imageURL.absoluteString.range(of: FeedCell.avatarImageSizeString) != nil else {
            return image
        }
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale);
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        UIBezierPath(roundedRect: rect, cornerRadius: FeedCell.avatarImageHeight / 2).addClip()
        image.draw(in: rect)
        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return result;
    }
    
    // MARK: Private methods
    
    func clickActionButton(sender: UIButton) {
        
    }
}

//
//  headPageView.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 4/13/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class HeadPageView: UIView {
    
    enum buttonState{
        case friends
        case following
        case add
    }
    
    public var image: UIImage?{
        didSet {
            contentView.image = image
            contentView.contentMode = .scaleAspectFill
        }
    }
    
    public var name: String?{
        didSet {
            nameLabel.text = name
            idLabel.text = "@" + name!
        }
    }
    
    public var status: String?{
        didSet{
            statusLabel.text = status
        }
    }
    
    public var friendsNumber: String?{
        didSet{
            self.friendsNum.text = friendsNumber
        }
    }
    public var followersNumber: String?{
        didSet{
            self.followersNum.text = followersNumber
        }
    }
    public var postsNumber: String?{
        didSet{
            self.postsNum.text = postsNumber
        }
    }
    
    public var relationsState: buttonState = .add{
        didSet{
            switch relationsState {
            case .friends:
                self.actionButton.setTitle("Friends", for: .normal)
            case .add:
                self.actionButton.setTitle("Add +", for: .normal)
                self.actionButton.backgroundColor = UIColor(red: 147, green: 85, blue: 230, alpha: 1)
            case .following:
                self.actionButton.setTitle("Following", for: .normal)
            }
        }
    }
    
    private var contentView: UIImageView!
    private var infoPanel: UIImageView = UIImageView(frame: CGRect(x: 0, y: 390, width: 375, height: 260) )
    
    private var detailInfoPanel = UIImageView(frame: CGRect(x: 5, y: 510, width: 365, height: 70))
    
    
    private var nameLabel = UILabel(frame: CGRect(x: 10, y: 400, width: 390, height: 50) )
    private var idLabel = UILabel(frame: CGRect(x: 10, y: 450, width: 390, height: 15) )
    private var statusLabel = UILabel(frame: CGRect(x: 10, y: 480, width: 390, height: 20) )
    
    private var friendsNum = UILabel(frame: CGRect(x: 10, y: 520, width: 100, height: 30) )
    private var followersNum = UILabel(frame: CGRect(x: 135, y: 520, width: 100, height: 30) )
    private var postsNum = UILabel(frame: CGRect(x: 260, y: 520, width: 100, height: 30) )
    
    private var stateFriends = UILabel(frame: CGRect(x: 10, y: 550, width: 100, height: 20) )
    private var stateFollowers = UILabel(frame: CGRect(x: 135, y: 550, width: 100, height: 20) )
    private var statePost = UILabel(frame: CGRect(x: 260, y: 550, width: 100, height: 20) )
    
    private var actionButton = UIButton(frame: CGRect(x: 20, y: 600, width: 165, height: 40) )
    private var chatButton = UIButton(frame: CGRect(x: 205, y: 600, width: 165, height: 40))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView = UIImageView(frame: bounds)
        contentView.clipsToBounds = true
        
        infoPanel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        nameLabel.font = UIFont(name: "Baskerville", size: CGFloat(35))
        nameLabel.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        idLabel.font = UIFont(name: "Helvetica Neue", size: CGFloat(14))
        idLabel.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        
        statusLabel.font = UIFont(name: "Helvetica Neue", size: CGFloat(20))
        statusLabel.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.numberOfLines = 2
        
        detailInfoPanel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        detailInfoPanel.clipsToBounds = true
        
        self.friendsNum.font = UIFont(name: "Baskerville", size: CGFloat(18))
        self.friendsNum.textAlignment = .center
        self.friendsNum.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.followersNum.font = UIFont(name: "Baskerville", size: CGFloat(18))
        self.followersNum.textAlignment = .center
        self.followersNum.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.postsNum.font = UIFont(name: "Baskerville", size: CGFloat(18))
        self.postsNum.textAlignment = .center
        self.postsNum.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        
        stateFriends.text = "Friends"
        stateFriends.font = UIFont(name: "Helvetica Neue", size: CGFloat(14))
        stateFriends.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        stateFriends.textAlignment = .center
        stateFollowers.text = "Followers"
        stateFollowers.font = UIFont(name: "Helvetica Neue", size: CGFloat(14))
        stateFollowers.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        stateFollowers.textAlignment = .center
        statePost.text = "Posts"
        statePost.font = UIFont(name: "Helvetica Neue", size: CGFloat(14))
        statePost.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        statePost.textAlignment = .center
        
        actionButton.titleLabel?.font = UIFont(name: "Baskerville", size: CGFloat(15))
        actionButton.titleLabel?.textAlignment = .center
        actionButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        actionButton.titleLabel?.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.actionButton.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
        
        chatButton.setTitle("Go to Chat", for: .normal)
        chatButton.titleLabel?.font = UIFont(name: "Baskerville", size: CGFloat(15))
        chatButton.titleLabel?.textAlignment = .center
        chatButton.titleLabel?.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        chatButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        addSubview(contentView)
        addSubview(infoPanel)
        addSubview(nameLabel)
        addSubview(idLabel)
        addSubview(detailInfoPanel)
        
        addSubview(statusLabel)
        addSubview(friendsNum)
        addSubview(stateFriends)
        addSubview(followersNum)
        addSubview(stateFollowers)
        addSubview(postsNum)
        addSubview(statePost)
        addSubview(actionButton)
        addSubview(chatButton)
        
    }
    
    @objc private func onTap(_ sender: UIButton){
        switch relationsState {
        case .add:
            relationsState = .following
        case .friends:
            relationsState = .add
        case .following:
            relationsState = .add
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        detailInfoPanel.layer.cornerRadius = CGFloat(15)
        actionButton.layer.cornerRadius = CGFloat(15)
        chatButton.layer.cornerRadius = CGFloat(15)
    }
}

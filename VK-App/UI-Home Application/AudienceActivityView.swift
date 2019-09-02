//
//  AudienceActivityView.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 3/19/19.
//  Copyright © 2019 Developer. All rights reserved.
//




//Under Develpoment!

import UIKit

class audienceActivity : UIControl {
    
    var likeSection : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
    
    var likeImage : UIImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
    var likeLabel : UILabel! = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height:20))
    var likeButton : UIButton! = UIButton(frame: CGRect(x: 55, y: 5, width: 60, height: 20))
    
    var commentSection : UIImageView = UIImageView(frame: CGRect(x: 140, y: 0, width: 120, height: 30))
    
    var commentButton : UIButton = UIButton(frame: CGRect(x: 145, y: 5, width: 115, height: 20))
    
    var likeCount = 0
    
    enum possibleButtonState {
        case on
        case off
    }
    
    var currentButtonState : possibleButtonState = .off
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        
//        self.layer.borderWidth = 0.5
//        self.layer.borderColor = UIColor.red.cgColor
//        self.layer.cornerRadius = 0.5
//        self.layer.masksToBounds = true
        
        
        self.likeImage.image = UIImage(imageLiteralResourceName: "noLike.png")
        self.likeLabel.text = "\(likeCount)"
        self.likeLabel.textColor = UIColor.black
        
        self.likeButton.setTitle("Like", for: .normal)
        self.likeButton.setTitleColor(.white, for: .normal)
        self.likeButton.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
        
        self.commentButton.setTitle("Comment", for: .normal)
        self.commentButton.setTitleColor(.white, for: .normal)
        self.commentButton.layer.cornerRadius = CGFloat(15)
        
        self.likeSection.layer.borderWidth = CGFloat(2)
        self.likeSection.layer.borderColor = UIColor(red: 40, green: 0, blue: 62, alpha: 0.8).cgColor
        self.likeSection.layer.cornerRadius = CGFloat(15)
        
        self.commentSection.layer.borderWidth = CGFloat(1.5)
        self.commentSection.layer.borderColor = UIColor(red: 40, green: 0, blue: 62, alpha: 0.8).cgColor
        self.commentSection.layer.cornerRadius = CGFloat(15)
        
        self.layer.backgroundColor = UIColor(red: 147, green: 85, blue: 230, alpha: 1).cgColor
        
        
        self.addSubview(likeButton)
        self.addSubview(likeLabel)
        self.addSubview(likeImage)
        self.addSubview(commentButton)
        self.addSubview(likeSection)
        self.addSubview(commentSection)
    }
    
    
    @objc private func onTap(_ sender: UIButton){
        
        
        UIView.animate(withDuration: 0.3) {
            
            switch self.currentButtonState {
            case .on:
                self.currentButtonState = .off
                self.likeCount -= 1
                UIView.transition(with: self.likeButton,
                                  duration: 0.2,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                self.likeButton.setTitle("Like", for: .normal)
                                self.likeButton.setTitleColor(.white, for: .normal)
                })
                self.likeImage.image = UIImage(imageLiteralResourceName: "noLike.png")
                self.likeLabel.textColor = UIColor.white
                
            case .off:
                self.currentButtonState = .on
                self.likeCount += 1
                UIView.transition(with: self.likeButton,
                                  duration: 0.2,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                self.likeButton.setTitle("Dislike", for: .normal)
                                self.likeButton.setTitleColor(.red, for: .normal)
                })
                self.likeImage.image = UIImage(imageLiteralResourceName: "aLike.png")
                self.likeLabel.textColor = UIColor.red
                
            }
            
            UIView.transition(with: self.likeLabel,
                              duration: 0.2,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.likeLabel.text = "\(self.likeCount)"
            })
        }
        
    }
}


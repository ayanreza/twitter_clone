//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Ayan Reza on 7/23/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

   
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetbutton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        
        let toBeFavorited = !favorited
        if(toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("favorite did not succeed: \(error)")
            })
            
        } else {
            
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("could not unfavorite tweet: \(error)")
            })
        }
        
    }
    @IBAction func retweet(_ sender: Any) {
        
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure:{ (error) in
        print("error is retweeting: \(error)") 
    })
        
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        
        if(isRetweeted) {
            
            retweetbutton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetbutton.isEnabled = false
        }
        else {
            retweetbutton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetbutton.isEnabled = true
        }
        
    }
    
    func setFavorite(_ isFavorited:Bool) {
        
        favorited = isFavorited
        if(favorited) {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named:"favor-icon-1"), for: UIControl.State.normal)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

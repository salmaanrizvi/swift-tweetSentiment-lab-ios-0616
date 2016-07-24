//
//  TwitterAPIClient.swift
//  swift-tweetSentiment-lab
//
//  Created by susan lovaglio on 7/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import STTwitter
import Twitter


class TwitterAPIClient {
    
    
    class func getAveragePolarityOfTweetsFromQuery(query: String, completion:(polarity: String) -> Void){
        
        let twitter = STTwitterAPI(appOnlyWithConsumerKey: Constants.TWITTER_KEY, consumerSecret: Constants.TWITTER_SECRET)
        
        twitter.verifyCredentialsWithUserSuccessBlock({ (userName, userID) in
            
            
            twitter.getSearchTweetsWithQuery(query, successBlock: { (searchMetaData, statuses) in
                
                Sentiment140API.getPolarityOfTweets(statuses as! [NSDictionary], query: query, completion: { (completionBlock) in
                completion(polarity: completionBlock)
                
                })
                
            }) { (error) in
                
                print("there was a search error: \(error.localizedDescription)")
            }

            
        }) { (error) in
            print("there was a credentials error: \(error.localizedDescription)")
        }
        
        
        
    }
    
}

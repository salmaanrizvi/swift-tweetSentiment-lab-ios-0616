//
//  Sentiment140API.swift
//  swift-tweetSentiment-lab
//
//  Created by susan lovaglio on 7/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation


class Sentiment140API {
    
    class func getPolarityOfTweets(tweets: [NSDictionary] ,query: String, completion:(String) -> Void){
        
        var totalPolarityValue = 0
        var averagePolarityValue = 0
        var numbrtOfTweetsCheckedForPolarity = 0
        let mySession = NSURLSession.sharedSession()
        
        for tweet in tweets{
            
            let sentiment140URL = Sentiment140API.urlFromTweet(tweet, query: query)
            let task = mySession.dataTaskWithURL(sentiment140URL, completionHandler: { (data, response, error) in
                
                if (error != nil) {
                    print(error?.localizedDescription)
                    completion("nil")
                }
                
                do{
                    if let unwrappedData = data{
                        
                    let resultsDictionary = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    
                    if let unwrappedResult = resultsDictionary["results"] as? NSDictionary{
                        
                        if let polarity = unwrappedResult["polarity"] as? Int{

                            totalPolarityValue += polarity
                        }
                    }
                    if numbrtOfTweetsCheckedForPolarity == tweets.count-1{
                        averagePolarityValue = totalPolarityValue/tweets.count
                        completion(String(averagePolarityValue))
                    }
                    }
                } catch{
                    
                    print("it's the sentiment catch error\(data): \(error) ")
                    
                }
                
                numbrtOfTweetsCheckedForPolarity += 1
 
                
                })
            task.resume()
        }
    }
    
    class func urlFromTweet(tweet: NSDictionary, query: String) -> NSURL{
        
        let unescapedTweetString = tweet["text"]
        
        let escapedTweetString = unescapedTweetString?.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        let sentimentedString = "\(Constants.SENTIMENT140_BASE_URL)&query=\(query)&text=\(escapedTweetString!)"
        
        let sentiment140URL = NSURL(string: sentimentedString)
        
        if let unwrappedReturnUrl = sentiment140URL{
            
            return unwrappedReturnUrl
        }
        
        return NSURL(string: "http://www.sentiment140.com/api/classify?appid=joe@flatironschool.com&language=en")!
    }
}

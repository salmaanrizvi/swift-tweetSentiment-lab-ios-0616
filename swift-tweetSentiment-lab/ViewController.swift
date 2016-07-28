//
//  ViewController.swift
//  swift-tweetSentiment-lab
//
//  Created by susan lovaglio on 7/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Twitter
import STTwitter

class ViewController: UIViewController {
    
    @IBOutlet weak var polarityScoreLabel: UILabel!
    
    var tweets : [String] = []
    var encodedTweets : [NSURL?] = []
    var tweetPolarity : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  self.analyzeTweets()
        
        self.getTweets {
            self.encodeTweets()
            
            print(self.encodedTweets)
            
            self.analyzeTweets({ (polarityOfTweets) in
                
                if polarityOfTweets.count == 15 {
                    NSOperationQueue.mainQueue().addOperationWithBlock({ 
                        
                        var sum : CGFloat = 0.0
                        
                        for integer in polarityOfTweets {
                            sum += CGFloat(integer)
                        }
                        
                        self.polarityScoreLabel.text = String(sum / CGFloat(polarityOfTweets.count))
                    })
                }
                
            })
        }
    }
    
    func encodeTweets() {
        for tweet in tweets {
            if let encodedTweet = tweet.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet()) {
                self.encodedTweets.append(NSURL(string: sentimentAPI + encodedTweet))
            }
        }
    }
    
    func analyzeTweets(completion : ([Int]) -> ()) {
        let urlSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        for encodedTweet in self.encodedTweets {
            
            if let validURL = encodedTweet {
                
                let urlTask = urlSession.dataTaskWithURL(validURL, completionHandler: { (data, response, error) in
                    do {
                        let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                        
                        print("Tweet Data:")
                        print(jsonData)
                        
                        let result = jsonData["results"] as! NSDictionary
                        let polarity = result["polarity"] as! NSNumber
                        
                        self.tweetPolarity.append(Int(polarity))
                        completion(self.tweetPolarity)
                        
                    }
                    catch {
                        
                    }
                })
                
                urlTask.resume()
            }
        }
    }
    
    
//    func analyzeTweet(escapedString : String) {
//     
//        let urlSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
//        
//        urlSession.dataTaskWithURL(NSURL(string: sentimentAPI + escapedString)!) { (data, response, error) in
//            do {
//                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
//                
//                print(jsonData)
//                
//                let result = jsonData["results"] as! NSDictionary
//                let polarity = result["polarity"] as! NSNumber
//                
//                self.tweetPolarity.append(Int(polarity))
//                
//            }
//            catch {
//                
//            }
//
//        }.resume()
//        
//    }
    
    
    func getTweets(completion: () -> ()) {
        
        let twitter : STTwitterAPI = STTwitterAPI(appOnlyWithConsumerKey: consumerKey, consumerSecret: consumerSecret)
        
        twitter.verifyCredentialsWithUserSuccessBlock({ (stringOne, stringTwo) in
            
            twitter.getSearchTweetsWithQuery("FlatironSchool", successBlock: { (dataDictionary, objectArray) in
                
                for tweet in objectArray {
                    
                    let tweetDict = tweet as! [NSString : AnyObject]
                    
                    if let tweetText = tweetDict["text"] {
                        self.tweets.append(tweetText as! String)
                    }
                }
                
                completion()
                
            }) { (error) in
                print("Could not Search Tweets with Query")
                print(error)
            }
            
            
        }) { (error) in
            print(error)
        }
    }
    
    
}


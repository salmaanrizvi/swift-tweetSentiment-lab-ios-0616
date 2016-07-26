//
//  TweetSentimentLabSpec.swift
//  swift-tweetSentiment-lab
//
//  Created by Flatiron School on 7/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import swift_tweetSentiment_lab

class TweetSentimentLabSpec: QuickSpec {
    
    
    override func spec() {
        
        let kTwitterRequestURL = "api.twitter.com"
        let kTwitterOauthURL = "https://api.twitter.com/oauth2/token"
        let kSentimentRequestURL = "sentiment140"
        let kPolarityOfEveryTweet = 20
        let kTwitterQuery = "FlatironSchool"
        
        
        describe("FISTwitterAPIClient()") {
            var httpTwitterStub: OHHTTPStubsDescriptor?
            var httpTwitterLoginStub: OHHTTPStubsDescriptor?
            var httpSentimentStub: OHHTTPStubsDescriptor?
            var responseObject: NSDictionary = [:]
            var loginResponse: NSDictionary = [:]
            var jsonString = ""
            var sentimentStubData: NSData?
            
            beforeSuite({
                
                let bundle = NSBundle.mainBundle()
                let filePath = bundle.pathForResource("fakeJSON", ofType: "json")
                
                if let file = filePath{
                    
                    let tweets = NSArray(contentsOfFile: file)
                    
                    responseObject = ["search_metadata": ["Data": "<3"],
                        "statuses" : tweets!]
                    //                    print("statuses \(responseObject)")
                    loginResponse = ["access_token" : "DONALD TRUMP",
                        "token_type" : "bearer"]
                    
                    jsonString = "{\"results\": {\"polarity\": \(kPolarityOfEveryTweet)}}"
                    
                    if let sentimentData = jsonString.dataUsingEncoding(NSUTF8StringEncoding){
                        sentimentStubData = sentimentData
                    }
                }
            })
            describe("getAveragePolarityOfTweetsFromQuery(_:withCompletion)", {
                
                beforeEach({
                    
                    OHHTTPStubs.removeAllStubs()
                    
                    httpTwitterStub = OHHTTPStubs.stubRequestsPassingTest({ (request) -> Bool in
                        
                        if let unwrappedrequest = request.URL{
                            
                            return unwrappedrequest.absoluteString.containsString(kTwitterRequestURL)
                            
                        }
                        
                        return false
                        
                        }, withStubResponse: { (request) -> OHHTTPStubsResponse in
                            
                            return OHHTTPStubsResponse(JSONObject: responseObject, statusCode: 200, headers:["Content-type": "application/json"])
                    })
                    
                    httpTwitterLoginStub = OHHTTPStubs.stubRequestsPassingTest({ (request) -> Bool in
                        
                        if let unwrappedrequest = request.URL{
                            
                            return unwrappedrequest.absoluteString == (kTwitterOauthURL)
                            
                        }
                        
                        return false
                        
                        }, withStubResponse: { (request) -> OHHTTPStubsResponse in
                            
                            return OHHTTPStubsResponse(JSONObject: loginResponse, statusCode: 200, headers: ["Content-type" : "application/json"])
                    })
                    
                    httpSentimentStub = OHHTTPStubs.stubRequestsPassingTest({ (request) -> Bool in
                        
                        if let unwrappedrequest = request.URL{
                            
                            return unwrappedrequest.absoluteString.containsString(kSentimentRequestURL)
                            
                        }
                        
                        return false
                        
                        }, withStubResponse: { (request) -> OHHTTPStubsResponse in
                            
                            return OHHTTPStubsResponse(data: sentimentStubData!, statusCode: 200, headers: nil)
                    })
                })
                
                it("should get the average polarity of tweets from the provided query.", closure: {
                    
                    waitUntil { done in
                        
                        TwitterAPIClient.getAveragePolarityOfTweetsFromQuery(kTwitterQuery, completion: { (polarity) in
                            //                        print("polarity: \(polarity)")
                            expect(polarity).notTo(equal(nil))
                            expect(polarity).to(equal("20"))
                            done()
                        })
                        
                    }
                    
                    
                })
                
            })
        }
    }
}


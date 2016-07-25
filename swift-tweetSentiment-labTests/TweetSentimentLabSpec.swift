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
        
        var httpTwitterStub: OHHTTPStubsDescriptor?
        var httpTwitterLoginStub: OHHTTPStubsDescriptor?
        var httpSentimentStub: OHHTTPStubsDescriptor?
        let kTwitterRequestURL = "api.twitter.com"
        let kTwitterOauthURL = "https://api.twitter.com/oauth2/token"
        let kSentimentRequestURL = "sentiment140"
        let kPolarityOfEveryTweet = "20"
        let kTwitterQuery = "FlatironSchool"
        var responseObject: NSDictionary = [:]
        var loginResponse: NSDictionary = [:]
        var jsonString = ""
        var sentimentStubData: NSData?
        
        describe("FISTwitterAPIClient()") {
            
            let bundle = NSBundle.mainBundle()
            let filePath = bundle.pathForResource("fakeJSON", ofType: "json")
//            print("file path: \(filePath)")
            
            if let file = filePath{
                
                let tweets = NSArray(contentsOfFile: file)
//                print("tweets: \(tweets)")
                
                responseObject = ["search_metadata": ["Data": "<3"],
                    "statuses" : tweets!]
//                print("response object: \(responseObject)")
                
                loginResponse = ["access_token" : "DONALD TRUMP",
                                     "token_type" : "bearer"]
//                print("loginResponse object: \(loginResponse)")
                
                jsonString = "{\"results\": {\"polarity\": \"\(kPolarityOfEveryTweet)\"}}"
//                print("jsonstring: \(jsonString)")
                
                if let sentimentData = jsonString.dataUsingEncoding(NSUTF8StringEncoding){
                    sentimentStubData = sentimentData
//                    print("sentimentData: \(sentimentData)")
                }
            }
            
        describe("getAveragePolarityOfTweetsFromQuery(_:withCompletion)", {
            
            OHHTTPStubs.removeAllStubs()
            httpTwitterStub = OHHTTPStubs.stubRequestsPassingTest({ (request) -> Bool in
                
                if let unwrappedrequest = request.URL{
                    
                    return unwrappedrequest.absoluteString.containsString(kTwitterRequestURL)
                    
                }
                
                return false
                
                }, withStubResponse: { (request) -> OHHTTPStubsResponse in
                    
                    return OHHTTPStubsResponse(JSONObject: responseObject, statusCode: 200, headers:["Content-type": "application/json"])

            })
            
            
        })
        }
    }
}
/*
 
 httpTwitterLoginStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
 return [[request.URL absoluteString] isEqualToString:kTwitterOauthURL];
 }
 withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
 return [OHHTTPStubsResponse responseWithJSONObject:loginResponse
 statusCode:200
 headers:@{@"Content-type": @"application/json"}];
 }];
 
 httpSentimentStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
 return [[request.URL absoluteString] containsString:kSentimentRequestURL];
 }
 withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
 return [OHHTTPStubsResponse responseWithData:sentimentStubData
 statusCode:200
 headers:nil];
 }];
 
 });
 
 it(@"should get the average polarity of tweets from the provided query.", ^{
 
 waitUntil(^(DoneCallback done) {
 
 [FISTwitterAPIClient getAveragePolarityOfTweetsFromQuery:kTwitterQuery
 withCompletion:^(NSNumber *polarity) {
 
 expect(polarity).to.beAKindOf([NSNumber class]);
 expect(polarity).notTo.equal(nil);
 expect(polarity).to.equal(20);
 
 done();
 }];
 });
 });
 });
 
 */

//
//  TwitterAPIClient.swift
//  swift-tweetSentiment-lab
//
//  Created by susan lovaglio on 7/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Twitter



//#import "FISTwitterAPIClient.h"
//#import "FISConstants.h"
//#import "FISSentiment140API.h"
//#import <STTwitter.h>
//
//@implementation FISTwitterAPIClient
//
//+ (void)getAveragePolarityOfTweetsFromQuery:(NSString *)query
//withCompletion:(void (^)(NSNumber *polarity))completionBlock {
//    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:TWITTER_KEY
//        consumerSecret:TWITTER_SECRET];
//    
//    [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
//        
//        NSLog(@"Username: %@ userID: %@", username, userID);
//        
//        
//        
//        [twitter getSearchTweetsWithQuery:query
//        successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
//        
//        NSLog(@" META DATA: %@", searchMetadata);
//        NSLog(@"Count of statuses: %ld", statuses.count);
//        
//        [FISSentiment140API getPolarityOfTweets:statuses
//        fromQuery:query
//        withCompletion:completionBlock];
//        } errorBlock:^(NSError *error) {
//        NSLog(@"%@", error.localizedDescription);
//        }];
//        } errorBlock:^(NSError *error) {
//        NSLog(@"%@", error.localizedDescription);
//        }];
//}

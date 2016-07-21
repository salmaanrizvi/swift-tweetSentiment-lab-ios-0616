//
//  Sentiment140API.swift
//  swift-tweetSentiment-lab
//
//  Created by susan lovaglio on 7/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation


//+ (void)getPolarityOfTweets:(NSArray *)tweets
//fromQuery:(NSString *)query
//withCompletion:(void (^)(NSNumber *))completionBlock {
//    
//    __block NSInteger totalPolarityValue = 0;
//    __block NSInteger averagePolarityValue;
//    __block NSInteger numberOfTweetsCheckedForPolarity = 0;
//    NSURLSession *mySession = [NSURLSession sharedSession];
//    
//    for (NSDictionary *tweet in tweets) {
//        NSURL *sentiment140URL = [FISSentiment140API urlFromTweet:tweet andQuery:query];
//        
//        NSURLSessionDataTask *task = [mySession dataTaskWithURL:sentiment140URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            
//            if (error) {
//            NSLog(@"%@", error.localizedDescription);
//            completionBlock(nil);
//            }
//            
//            NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSString *polarity = resultsDictionary[@"results"][@"polarity"];
//            
//            NSLog(@"=========Polarity = %@\n\n", polarity);
//            
//            totalPolarityValue += [polarity integerValue];
//            
//            if (numberOfTweetsCheckedForPolarity == [tweets count]-1) {
//            averagePolarityValue = totalPolarityValue/[tweets count];
//            completionBlock(@(averagePolarityValue));
//            }
//            
//            numberOfTweetsCheckedForPolarity++;
//            
//            }];
//        [task resume];
//    }
//    }
//    
//    + (NSURL *)urlFromTweet:(NSDictionary *)tweet andQuery:(NSString *)query {
//        NSString *unescapedTweetString = tweet[@"text"];
//        NSString *escapedTweetString = [unescapedTweetString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
//        NSString *sentimentedString = [NSString stringWithFormat:@"%@&query=%@&text=%@",SENTIMENT140_BASE_URL, query, escapedTweetString];
//        NSURL *sentiment140URL = [NSURL URLWithString:sentimentedString];
//        return sentiment140URL;
//}
//
//@end

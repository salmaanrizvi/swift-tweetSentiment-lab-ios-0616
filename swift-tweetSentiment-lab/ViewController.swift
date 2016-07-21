//
//  ViewController.swift
//  swift-tweetSentiment-lab
//
//  Created by Flatiron School on 7/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

//#import "FISViewController.h"
//#import "FISTwitterAPIClient.h"
//
//@interface FISViewController ()
//
//@property (weak, nonatomic) IBOutlet UILabel *polarityLabel;
//
//@end
//
//
//@implementation FISViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [FISTwitterAPIClient getAveragePolarityOfTweetsFromQuery:@"FlatironSchool"
//    withCompletion:^(NSNumber *polarity) {
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//    self.polarityLabel.text = [polarity stringValue];
//    }];
//    }];
//}
//
//@end
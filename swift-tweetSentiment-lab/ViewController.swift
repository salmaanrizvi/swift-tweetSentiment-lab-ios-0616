//
//  ViewController.swift
//  swift-tweetSentiment-lab
//
//  Created by susan lovaglio on 7/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var polarityScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterAPIClient.getAveragePolarityOfTweetsFromQuery("FlatironSchool") { (polarity) in
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.polarityScoreLabel.text = polarity
            })        }
        
    }
}


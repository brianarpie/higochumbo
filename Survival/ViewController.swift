//
//  ViewController.swift
//  Survival
//
//  Created by Brian Arpie on 7/30/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    // Play a nice tune for the title screen
    func BackgroundMusic() {
        if let path = NSBundle.mainBundle().pathForResource("title_music", ofType: "mp3") {
            let themeMusic = NSURL(fileURLWithPath: path)
            print(themeMusic)
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: themeMusic)
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch _ {
                // don't play any music :(
            }

        }
    }
    

    
    @IBOutlet var gameSummaryLabel: UILabel!
    
    @IBAction func newGameButton(sender: UIButton) {
        
    }
    @IBAction func leaderboardButton(sender: UIButton) {
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        BackgroundMusic()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


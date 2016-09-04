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
    func SeedDatabase() {
        let db = SQLiteDataStore.sharedInstance
        
        do {
            try db.createTables()
            
        } catch _ {}
        
        do {
            print("seeding")
            
            let hero_id = try HeroDataHelper.createHero()

            let item_id = try ItemDataHelper.insert("frozen_staff",
                display_name:"Frozen Staff",
                description:"An icy shaft... Oops, I mean't staff.",
                level_required: 1,
                price: 300
            )
            
            try ItemDataHelper.update_hero_id(item_id, hero_id: hero_id)

        } catch _ {}
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
        SeedDatabase()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


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
            
//            let hero_id = try HeroDataHelper.createHero()
            
            // TODO: make insert function return item if already exists.
            // .. even though this code should only exist in a seed function (during user installation?)
//            let item_id = try ItemDataHelper.insert("frozen_staff",
//                display_name:"Frozen Staff",
//                description:"An icy shaft... Oops, I mean't staff.",
//                level_required: 1,
//                price: 400
//            )
//            let magic_sword_id = try ItemDataHelper.insert("magic_sword",
//                                      display_name:"Magic Sword",
//                                      description:"A powerful magical sword.",
//                                      level_required: 2,
//                                      price: 200
//            )
//            print(magic_sword_id)
//            let swift_boots_id = try ItemDataHelper.insert("swift_boots",
//                                      display_name:"Swift Boots",
//                                      description:"Useful boots to make you faster.",
//                                      level_required: 1,
//                                      price: 900
//            )
//            print(swift_boots_id)
//            let purple_haze_id = try ItemDataHelper.insert("purple_haze",
//                                      display_name:"Purple Haze",
//                                      description:"The kind that you don't need to light on fire.",
//                                      level_required: 1,
//                                      price: 20
//            )
            
            // call this method when the hero purchases an item -> rename this at some point
//            try ItemDataHelper.update_hero_id(1, hero_id: hero_id)
//            try ItemDataHelper.update_hero_id(2, hero_id: hero_id)
//            
//            // let's test out some basic
//            let purchasedItems = try ItemDataHelper.getPurchasedItems()
//            let itemsForSale = try ItemDataHelper.getItemsForSale()
//            
//            print("Items Owned:")
//            for item in purchasedItems {
//                print("Name: \(item.displayName!), Cost: \(item.price!), Description: \(item.description!)")
//            }
//            
//            print("Items Available for Sale:")
//            for item in itemsForSale {
//                print("Name: \(item.displayName!), Cost: \(item.price!), Description: \(item.description!)")
//            }

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


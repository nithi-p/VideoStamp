//
//  ViewController.swift
//  Prototype1
//
//  Created by Yuchi on 19/4/16.
//  Copyright © 2016 Yuchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var weatherCondition: UILabel!
    var ref = Firebase(url: "https://videostamp.firebaseio.com/")

    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view, typically from a nib.
        ref.observeEventType(.Value, withBlock: {
            snapshot in
            self.weatherCondition.text = snapshot.value as? String
            
        })
        
    }
    
    @IBAction func update(sender: UIButton) {
//        let alanisawesome = ["full_name": "Alan Turing", "date_of_birth": "June 23, 1912"]
//        let gracehop = ["full_name": "Grace Hopper", "date_of_birth": "December 9, 1906"]
//        
        let usersRef = ref.childByAppendingPath("hello")
//
//        let users = ["alanisawesome": alanisawesome, "gracehop": gracehop]
        
        usersRef.updateChildValues([
            "alanisawesome/nickname": "Alan The Machine",
            "gracehop/nickname": "Amazing Grace"
            ])
        
//        hopperRef.updateChildValues(nickname)
//        usersRef.setValue(users)
  
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


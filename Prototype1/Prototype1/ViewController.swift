//
//  ViewController.swift
//  Prototype1
//
//  Created by Yuchi on 19/4/16.
//  Copyright © 2016 Yuchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet var myTextField: UITextField!

    @IBOutlet var myTextLabel: UILabel!
    var ref = Firebase(url: "https://videostamp.firebaseio.com/")

    
    override func viewDidLoad() {
		
		super.viewDidLoad()

		
        ref.observeEventType(.Value, withBlock: {
            snapshot in
            self.myTextLabel.text = snapshot.value.objectForKey("12345") as? String
			print(snapshot.value)
            
        })
        
    }
    
    @IBAction func update(sender: UIButton) {

        let usersRef = ref.childByAppendingPath("12345")
        usersRef.setValue(myTextField.text)
  
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


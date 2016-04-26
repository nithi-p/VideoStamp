//
//  ViewController.swift
//  Prototype1
//
//  Created by Yuchi on 19/4/16.
//  Copyright © 2016 Yuchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BarcodeDelegate {
	

	
	@IBOutlet var myTextField: UITextField!

	@IBOutlet var myTextLabel: UILabel!
	
    var ref = Firebase(url: "https://videostamp.firebaseio.com/")
	var newURL = ""
    var description = ""


    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	

	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		
		let barcodeViewController: BarcodeViewController = segue.destinationViewController as! BarcodeViewController
		barcodeViewController.delegate = self
		
	}
	
	func barcodeReaded(barcode: String) {
		print(barcode)
		newURL += barcode
		myTextLabel.text = newURL
		print(newURL)
		//myWebView.loadRequest(NSURLRequest(URL: NSURL(string: newURL)!))
//		ref.observeEventType(.Value, withBlock: {
//			snapshot in
//			self.myTextLabel.text = snapshot.value.objectForKey(self.newURL) as? String
//			
//		})
	}
	
	
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		ref.observeEventType(.Value, withBlock: {
			snapshot in
			self.myTextLabel.text = snapshot.value.objectForKey(self.newURL) as? String
			
		})

		
	}
	
	
	@IBAction func update(sender: UIButton) {
		
		let usersRef = ref.childByAppendingPath(newURL)
		usersRef.setValue(myTextField.text)
  
	}
	
	
	
	
	


}


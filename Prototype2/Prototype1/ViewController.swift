//
//  ViewController.swift
//  Prototype1
//
//  Created by Yuchi on 19/4/16.
//  Copyright © 2016 Yuchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BarcodeDelegate {
	

	@IBOutlet var myTextStatus: UILabel!
	
	@IBOutlet var myTextField: UITextField!

	@IBOutlet var myTextLabel: UILabel!
	
    var ref = Firebase(url: "https://videostamp.firebaseio.com/")
	var theCode = "Empty"
    var theText = "-"


    

	
	func setTimeout(delay:NSTimeInterval, block:()->Void) -> NSTimer {
		return NSTimer.scheduledTimerWithTimeInterval(delay, target: NSBlockOperation(block: block), selector: "main", userInfo: nil, repeats: false)
	}
 

	

	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		let barcodeViewController: BarcodeViewController = segue.destinationViewController as! BarcodeViewController
			barcodeViewController.delegate = self
		
	}
	
	
	
	func barcodeReaded(barcode: String) {
		print(barcode)
		theCode = barcode
		myTextLabel.text = theCode
		
		ref.observeEventType(.Value, withBlock: {
			snapshot in
			self.myTextField.text = snapshot.value.objectForKey(self.theCode) as? String
			
		})
		
		myTextStatus.text = ""
		
		
		
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
			self.myTextField.text = snapshot.value.objectForKey(self.theCode) as? String
			
		})

		myTextStatus.text = ""
	}
	
	
	@IBAction func update(sender: UIButton) {
		
		let usersRef = ref.childByAppendingPath(theCode)
		usersRef.setValue(myTextField.text)
		myTextStatus.text = "Posted!"
		
		_ = setTimeout(1, block: { () -> Void in
			self.myTextStatus.text = ""
		})
		
		
  
	}
	
	
	
	
	


}


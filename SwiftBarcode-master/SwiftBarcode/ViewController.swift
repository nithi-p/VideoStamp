

import UIKit

class ViewController: UIViewController, BarcodeDelegate {

	@IBOutlet var myWebView: UIWebView!
    @IBOutlet weak var codeTextView: UITextView!
	var newURL = "https://nithi-p.github.io/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        
        let barcodeViewController: BarcodeViewController = segue.destinationViewController as! BarcodeViewController
        barcodeViewController.delegate = self
        
    }
    
    func barcodeReaded(barcode: String) {
        print(barcode)
		newURL += barcode
		codeTextView.text = newURL
		print(newURL)
		myWebView.loadRequest(NSURLRequest(URL: NSURL(string: newURL)!))
    }
}


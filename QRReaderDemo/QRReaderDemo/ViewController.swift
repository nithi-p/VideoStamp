

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var messageLabel:UILabel!

	var captureSession:AVCaptureSession?
	var videoPreviewLayer:AVCaptureVideoPreviewLayer?
	var qrCodeFrameView:UIView?
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


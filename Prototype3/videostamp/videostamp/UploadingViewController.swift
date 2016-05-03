//
//  UploadingViewController.swift
//  videostamp
//
//  Created by Yuchi on 28/4/16.
//  Copyright © 2016 Yuchi. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var selectImageButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var display: UIButton!
    
    var testname: String = "2016_02_11_23_02_32"
    let S3BucketName = "videostamp2"
    
    var uploadRequests = Array<AWSS3TransferManagerUploadRequest?>()
    var uploadFileURLs = Array<NSURL?>()
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func buttonTapped (){
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        let error = NSErrorPointer()
        do {
            try NSFileManager.defaultManager().createDirectoryAtURL(
                NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("upload"),
                withIntermediateDirectories: true,
                attributes: nil)
        } catch let error1 as NSError {
            error.memory = error1
            print("Creating 'upload' directory failed. Error: \(error)")
        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func displayTapped(){
        
        let urlPath: String = "https://s3.amazonaws.com/videostamp2/\(testname).mp4"
        let url: NSURL = NSURL(string: urlPath)!

        print("tapped")
        let player = AVPlayer(URL: url)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.addChildViewController(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame
        
        player.play()

    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let fileName = NSProcessInfo.processInfo().globallyUniqueString.stringByAppendingString(".png")
            let fileURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("upload").URLByAppendingPathComponent(fileName)
            let filePath = fileURL.path!
            
            let imageData = UIImagePNGRepresentation(pickedImage)
            imageData!.writeToFile(filePath, atomically: true)
            
            let uploadRequest = AWSS3TransferManagerUploadRequest()
            uploadRequest.body = fileURL
            uploadRequest.key = fileName
            uploadRequest.bucket = S3BucketName
            uploadRequest.ACL = AWSS3ObjectCannedACL.BucketOwnerFullControl
            
//            uploadRequest = AWSS3Permission.FullControl
            
            self.uploadRequests.append(uploadRequest)
            self.uploadFileURLs.append(nil)
            
            self.upload(uploadRequest)
            imageView.contentMode = .ScaleAspectFill
            imageView.image = pickedImage
            
        }
        
    }
    
    func upload(uploadRequest: AWSS3TransferManagerUploadRequest) {
        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
        
        transferManager.upload(uploadRequest).continueWithBlock { (task) -> AnyObject! in
            if let error = task.error {
                if error.domain == AWSS3TransferManagerErrorDomain as String {
                    if let errorCode = AWSS3TransferManagerErrorType(rawValue: error.code) {
                        switch (errorCode) {
                        case .Cancelled, .Paused:
                                print("don't know what's going on")
                            break;
                            
                        default:
                            print("upload() failed: [\(error)]")
                            break;
                        }
                    } else {
                        print("upload() failed: [\(error)]")
                    }
                } else {
                    print("upload() failed: [\(error)]")
                }
            }
            
            if let exception = task.exception {
                print("upload() failed: [\(exception)]")
            }
            
            if task.result != nil {
                
//                print("working")
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    if (self.uploadRequests, uploadRequest: uploadRequest) {
//                        self.uploadRequests = nil
//                        self.uploadFileURLs = uploadRequest.body
//                        
//                        let indexPath = NSIndexPath(forRow: index, inSection: 0)
//                        self.collectionView.reloadItemsAtIndexPaths([indexPath])
//                    }
//                })
            }
            return nil
        }
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

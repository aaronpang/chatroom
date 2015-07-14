//
//  SecondViewController.swift
//  chatroom
//
//  Created by Aaron Pang on 2015-07-07.
//  Copyright © 2015 Aaron Pang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var profilePicImageView: UIImageView!

  override func loadView() {
    super.loadView()
    FacebookManager.sharedInstance.requestID { (result, error) -> () in
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        if let resultString = result as? String {
          self.nameLabel.text = resultString
        }
      })
    }
    
    
    let request = FBSDKGraphRequest(graphPath: "/me", parameters:["fields" :
      "picture.height(\(Int(profilePicImageView.frame.size.height))).width(\(Int(profilePicImageView.frame.size.width)))"])
    request.startWithCompletionHandler { (connection, result, error) -> Void in
      if error != nil {
        print(error)
      }
      let url = result["picture"]
      print(result)
    }
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }


}


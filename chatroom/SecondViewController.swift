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
    FacebookManager.sharedInstance.requestName { (result, error) -> () in
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.nameLabel.text = result
      })
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


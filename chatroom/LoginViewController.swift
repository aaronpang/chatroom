//
//  LoginViewController.swift
//  chatroom
//
//  Created by Aaron Pang on 2015-07-09.
//  Copyright © 2015 Aaron Pang. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
  @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!

  override func loadView() {
    super.loadView()
    facebookLoginButton.readPermissions = ["public_profile", "email", "user_friends",]
  }
}

extension LoginViewController : FBSDKLoginButtonDelegate {
  func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    guard error == nil else {
      // Process error
      return
    }
    
    if result.isCancelled {
    } else {
      performSegueWithIdentifier("loginViewControllerSegue", sender: self)
    }
  }
  func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
  }
}
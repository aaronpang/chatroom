//
//  FacebookManager.swift
//  chatroom
//
//  Created by Aaron Pang on 2015-07-10.
//  Copyright © 2015 Aaron Pang. All rights reserved.
//

import Foundation

enum FacebookManagerErrorCode: Int {
  case NoFBSDKAccessToken = 100
}

enum FacebookManagerObjectKey: String {
  case name = "FBName"
}


class FacebookManager {
  static let sharedInstance = FacebookManager()
  private var name: String?
  private let graphPathDictionary = [FacebookManagerObjectKey.name: ("me", "name")]
  
  func requestName(completion: (result: AnyObject?, error: NSError?) -> ()) {
    requestFBObject(completion)
  }
  
  func requestFBObject(completion: (result: AnyObject?, error: NSError?) -> ()) {
    guard FBSDKAccessToken.currentAccessToken() != nil else {
      let errorCode = FacebookManagerErrorCode.NoFBSDKAccessToken
      let error = NSError(domain: "FacebookManager", code: errorCode.rawValue, userInfo: ["localizedDescription" : "User is not logged into Facebook on Chatroom."])
      completion(result: nil, error: error)
      return
    }
    // If the name exists in the singleton, return that. If not, grab it from the user defaults. If it doesn't exist there, make a graph request
    if name == nil {
      if let nameFromDefaults = NSUserDefaults.standardUserDefaults().objectForKey("fbName") as? String {
        name = nameFromDefaults
      } else {
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
          guard error == nil else {
            completion(result: nil, error: error)
            return
          }
          if let name = result["name"] as? String {
            self.name = name
            NSUserDefaults.standardUserDefaults().setObject(name, forKey: "fbName")
            completion(result: name, error: nil)
          }
        })
        return
      }
    }
    completion(result:name, error:nil)
  }
}
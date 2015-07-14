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

enum FacebookManagerObjectID: String {
  case Name = "FBName"
  case ID = "FBUID"
}

class FacebookManager {
  static let sharedInstance = FacebookManager()
  private var name: String?
  private let graphPathDictionary: [FacebookManagerObjectID: (graphPath: String, resultKey: String)] = [
    .Name : ("me", "name"),
    .ID : ("me", "id")
  ]
  
  func requestName(completion: (result: AnyObject?, error: NSError?) -> ()) {
    requestFBObject(.Name, completion: completion)
  }
  
  func requestID(completion: (result: AnyObject?, error: NSError?) -> ()) {
    requestFBObject(.ID, completion: completion)
  }
  
  //: MARK - Private
  private func requestFBObject(objectID: FacebookManagerObjectID, completion: (result: AnyObject?, error: NSError?) -> ()) {
    guard FBSDKAccessToken.currentAccessToken() != nil else {
      let errorCode = FacebookManagerErrorCode.NoFBSDKAccessToken
      let error = NSError(domain: "FacebookManager", code: errorCode.rawValue, userInfo: ["localizedDescription" : "User is not logged into Facebook on Chatroom."])
      completion(result: nil, error: error)
      return
    }
    // If the name exists in the singleton, return that. If not, grab it from the user defaults. If it doesn't exist there, make a graph request
    if name == nil {
      if let nameFromDefaults = NSUserDefaults.standardUserDefaults().objectForKey(objectID.rawValue) as? String {
        name = nameFromDefaults
      } else {
        guard let graphPathObject = graphPathDictionary[objectID] else {
          print("Unable to retrieve object with ID: \(objectID.rawValue) from dictionary")
          return
        }
        let graphRequest = FBSDKGraphRequest(graphPath: graphPathObject.graphPath, parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
          guard error == nil else {
            completion(result: nil, error: error)
            return
          }
          if let name = result[graphPathObject.resultKey] as? String {
            self.name = name
            NSUserDefaults.standardUserDefaults().setObject(name, forKey: objectID.rawValue)
            completion(result: name, error: nil)
          }
        })
        return
      }
    }
    completion(result:name, error:nil)
  }
}
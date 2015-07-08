//
//  FirstViewController.swift
//  chatroom
//
//  Created by Aaron Pang on 2015-07-07.
//  Copyright © 2015 Aaron Pang. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
  var topicList = [CRTopicObject]()
  
  //! IBOutlets
  @IBOutlet weak var tableview: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension FirstViewController : UITableViewDelegate {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var tableViewCell: FirstViewTableViewCell? = nil
    tableViewCell = self.tableview.dequeueReusableCellWithIdentifier("firstViewTableViewCellIdentifier") as? FirstViewTableViewCell
    if let existingTableViewCell = tableViewCell {
      return existingTableViewCell
    }
    // Conservative approach - this should always return back a cell
    return FirstViewTableViewCell()
  }
}

extension FirstViewController : UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return topicList.count
    return 5
  }
}




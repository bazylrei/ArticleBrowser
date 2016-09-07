
//
//  DetailVC.swift
//  ArticleBrowser
//
//  Created by Bazyl Reinstein on 07/09/2016.
//  Copyright © 2016 Bazyl Reinstein. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
  
  @IBOutlet weak var labelSubtitle: UILabel!
  @IBOutlet weak var labelDate: UILabel!
  @IBOutlet weak var textViewBody: UITextView!
  var article: Article?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateViewDetails()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    let manager = DataManager()
    manager.downloadArticleDetails((article?.id)!) { () in
      self.updateViewDetails()
    }
  }

  func updateViewDetails() {
    labelSubtitle.text = article?.subtitle
    labelDate.text = article?.date
    textViewBody.text = article?.body
    self.navigationItem.title = article?.title
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

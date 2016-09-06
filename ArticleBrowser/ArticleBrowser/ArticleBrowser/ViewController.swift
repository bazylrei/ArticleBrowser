//
//  ViewController.swift
//  ArticleBrowser
//
//  Created by Bazyl Reinstein on 06/09/2016.
//  Copyright © 2016 Bazyl Reinstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let manager = DataManager()
    manager.saveDownloadedArticles()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


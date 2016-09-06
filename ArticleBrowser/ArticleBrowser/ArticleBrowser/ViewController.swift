//
//  ViewController.swift
//  ArticleBrowser
//
//  Created by Bazyl Reinstein on 06/09/2016.
//  Copyright © 2016 Bazyl Reinstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  var articles: [Article]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let manager = DataManager()
    manager.downloadedArticles() { [weak self] in
      dispatch_async(dispatch_get_main_queue(), { 
        self?.articles = manager.getArticles()
        self?.tableView.reloadData()
      })
    }
  }


}

//MARK: UITableViewDataSource
extension ViewController {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let articles = articles else {
      return 0
    }
    print(articles.count)
    return articles.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath)
    let article = articles![indexPath.row]
    print(article)
    cell.textLabel?.text = article.title
    cell.detailTextLabel?.text = article.subtitle
    return cell
  }
}

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
  var articles: [Article]? {
    didSet(oldValue) {
      
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let manager = DataManager()
    manager.downloadedArticles() { [weak self] in
      dispatch_async(dispatch_get_main_queue(), { 
        self?.articles = manager.getArticles().sort{return $0.title < $1.title}
        self?.tableView.reloadData()
      })
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "detailSegue" {
      let detailVC = segue.destinationViewController as! DetailVC
      if let sender = sender {
        detailVC.article = sender as? Article
      }
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
    return articles.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath)
    guard let articles = articles else {
      return cell
    }
    let article = articles[indexPath.row]
    
    cell.textLabel?.text = article.title
    cell.detailTextLabel?.text = article.subtitle
    return cell
  }
}

//MARK: UITableViewDelegate

extension ViewController {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    guard let articles = articles else {
      return
    }
    let article = articles[indexPath.row]
    self.performSegueWithIdentifier("detailSegue", sender: article)
  }
}

//
//  DataManager.swift
//  ArticleBrowser
//
//  Created by Bazyl Reinstein on 06/09/2016.
//  Copyright © 2016 Bazyl Reinstein. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
  
  let manager = DataDownloader()
  
  func downloadedArticles(completion: (Void) -> Void) {
    
    manager.getArticles { (dictionary) in
      let articles = dictionary.valueForKey("items") as! [[NSObject: AnyObject]]
      for article in articles {
        Article.createArticleObjectWithDictionary(article)
      }
      completion()
    }
  }
  
  func downloadArticleDetails(articleID: NSNumber, completion: (Void) -> Void) {
    manager.getArticleDetails(articleID) { (dictionary) in
      let article = dictionary.valueForKey("item") as! [NSObject: AnyObject]
      Article.createArticleObjectWithDictionary(article)
    }
    
  }
  
  func getArticles() -> [Article] {
    let coreData = CoreDataWrapper.sharedWrapper
    let context = coreData.managedObjectContext
    let articleFetch = NSFetchRequest(entityName: "Article")
    do {
      let fetchedArticles = try context.executeFetchRequest(articleFetch) as! [Article]
      return fetchedArticles
    } catch {
      fatalError("Failed to fetch employees: \(error)")
    }
  }
  
}

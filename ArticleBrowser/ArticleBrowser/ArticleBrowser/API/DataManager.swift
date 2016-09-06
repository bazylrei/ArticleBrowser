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
    
  func downloadedArticles(completion: (Void) -> Void) {
    let manager = DataDownloader()
    manager.getArticles { (dictionary) in
      let articles = dictionary.valueForKey("items") as! [[NSObject: AnyObject]]
      for article in articles {
        Article.createArticleObjectWithDictionary(article)
      }
      completion()
    }
  }
  
  func getArticles() -> [Article] {
    let coreData = CoreDataWrapper()
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

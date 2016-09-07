//
//  Article.swift
//  ArticleBrowser
//
//  Created by Bazyl Reinstein on 06/09/2016.
//  Copyright © 2016 Bazyl Reinstein. All rights reserved.
//

import Foundation
import CoreData


class Article: NSManagedObject {

  class func createArticleObjectWithDictionary(dict: Dictionary<NSObject, AnyObject>) {
    let coreData = CoreDataWrapper()
    let context = coreData.managedObjectContext
    let articleFetch = NSFetchRequest(entityName: "Article")
    articleFetch.predicate = NSPredicate(format: "id = %@", (dict["id"]! as? NSNumber)!)
    let fetchedArticles: [Article]!
    let article: Article!
    
    do {
      fetchedArticles = try context.executeFetchRequest(articleFetch) as! [Article]
    } catch {
      fatalError("Failed to fetch employees: \(error)")
    }
    if fetchedArticles.count > 0 {
      article = fetchedArticles[0]
    } else {
    article = NSEntityDescription.insertNewObjectForEntityForName("Article",
                                                                      inManagedObjectContext: coreData.managedObjectContext) as! Article
    }
    
    
    article.id = dict["id"]! as? NSNumber
    article.title = dict["title"]! as? String
    article.subtitle = dict["subtitle"]! as? String
    article.date = dict["date"]! as? String
    coreData.saveContext()
  }

}

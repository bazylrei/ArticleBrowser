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
    let article = NSEntityDescription.insertNewObjectForEntityForName("Article",
                                                                      inManagedObjectContext: coreData.managedObjectContext) as! Article
    article.id = dict["id"]! as? NSNumber
    article.title = dict["title"]! as? String
    article.subtitle = dict["subtitle"]! as? String
    article.date = dict["date"]! as? String
    print(article)
    coreData.saveContext()
  }

}

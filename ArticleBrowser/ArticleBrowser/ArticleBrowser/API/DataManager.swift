//
//  DataManager.swift
//  ArticleBrowser
//
//  Created by Bazyl Reinstein on 06/09/2016.
//  Copyright © 2016 Bazyl Reinstein. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
  func saveDownloadedArticles() {
    let manager = DataDownloader()
    manager.getArticles { (dictionary) in
      let articles = dictionary.valueForKey("items") as! [[NSObject: AnyObject]]
      for article in articles {
        Article.createArticleObjectWithDictionary(article)
      }
    }
  }
  
}

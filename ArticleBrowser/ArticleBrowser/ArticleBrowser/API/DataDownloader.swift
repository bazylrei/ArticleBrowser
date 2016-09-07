//
//  DataDownloader.swift
//  ArticleBrowser
//
//  Created by Bazyl Reinstein on 06/09/2016.
//  Copyright © 2016 Bazyl Reinstein. All rights reserved.
//

import UIKit

class DataDownloader: NSObject {

  let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
  var dataTask: NSURLSessionDataTask?
  
  enum JSONError: String, ErrorType {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
  }
  
  func getArticles(completion: (NSDictionary) -> Void) {
    if dataTask != nil {
      dataTask?.cancel()
    }
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    let url = NSURL(string: Constants.URLs.baseURL)
    dataTask = defaultSession.dataTaskWithURL(url!) {
      data, response, error in
      dispatch_async(dispatch_get_main_queue()) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
      }
      if let error = error {
        print(error.localizedDescription)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode == 200 {
          do {
            guard let data = data else {
              throw JSONError.NoData
            }
            guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary else {
              throw JSONError.ConversionFailed
            }
            completion(json)
          } catch let error as JSONError {
            print(error.rawValue)
          } catch let error as NSError {
            print(error.debugDescription)
          }
        }
      }
    }
    dataTask?.resume()
  }
  
  func getArticleDetails(articleID: NSNumber, completion: (NSDictionary) -> Void) {
    if dataTask != nil {
      dataTask?.cancel()
    }
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    let url = NSURL(string: Constants.URLs.articleDetailURL + String(articleID) + ".json")
    dataTask = defaultSession.dataTaskWithURL(url!) {
      data, response, error in
      dispatch_async(dispatch_get_main_queue()) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
      }
      if let error = error {
        print(error.localizedDescription)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode == 200 {
          do {
            guard let data = data else {
              throw JSONError.NoData
            }
            guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary else {
              throw JSONError.ConversionFailed
            }
            completion(json)
          } catch let error as JSONError {
            print(error.rawValue)
          } catch let error as NSError {
            print(error.debugDescription)
          }
        }
      }
    }
    dataTask?.resume()

    
  }
  
  
}

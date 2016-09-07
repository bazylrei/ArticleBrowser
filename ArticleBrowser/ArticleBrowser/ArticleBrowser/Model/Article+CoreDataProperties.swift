//
//  Article+CoreDataProperties.swift
//  ArticleBrowser
//
//  Created by Bazyl Reinstein on 07/09/2016.
//  Copyright © 2016 Bazyl Reinstein. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Article {

    @NSManaged var date: String?
    @NSManaged var id: NSNumber?
    @NSManaged var subtitle: String?
    @NSManaged var title: String?
    @NSManaged var body: String?

}

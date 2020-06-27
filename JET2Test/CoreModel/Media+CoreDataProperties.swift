//
//  Media+CoreDataProperties.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import Foundation
import CoreData


extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        return NSFetchRequest<Media>(entityName: "Media")
    }

    @NSManaged public var blogId: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var article: NSSet?

}

// MARK: Generated accessors for article
extension Media {

    @objc(addArticleObject:)
    @NSManaged public func addToArticle(_ value: Articles)

    @objc(removeArticleObject:)
    @NSManaged public func removeFromArticle(_ value: Articles)

    @objc(addArticle:)
    @NSManaged public func addToArticle(_ values: NSSet)

    @objc(removeArticle:)
    @NSManaged public func removeFromArticle(_ values: NSSet)

}

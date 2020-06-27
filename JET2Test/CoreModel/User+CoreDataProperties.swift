//
//  User+CoreDataProperties.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var about: String?
    @NSManaged public var avatar: String?
    @NSManaged public var blogId: String?
    @NSManaged public var city: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var designation: String?
    @NSManaged public var id: String?
    @NSManaged public var lastname: String?
    @NSManaged public var name: String?
    @NSManaged public var article: NSSet?

}

// MARK: Generated accessors for article
extension User {

    @objc(addArticleObject:)
    @NSManaged public func addToArticle(_ value: Articles)

    @objc(removeArticleObject:)
    @NSManaged public func removeFromArticle(_ value: Articles)

    @objc(addArticle:)
    @NSManaged public func addToArticle(_ values: NSSet)

    @objc(removeArticle:)
    @NSManaged public func removeFromArticle(_ values: NSSet)

}

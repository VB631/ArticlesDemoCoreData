//
//  ArticlesViewModel.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import CoreData

@objc protocol  ArticlesViewModelDelegate:class
{
    @objc optional
    func didFetchArticlesData(responseData:Any) ->  Void
    @objc optional
    func didFailArticlesDataWithError(error:NSError) -> Void
    
}

class ArticlesViewModel: TemplateMainService,AppMainServiceDelegate {
    
    static let sharedInstance :ArticlesViewModel =
    {
        let instance = ArticlesViewModel()
        return instance
        
    }()
    
    private override init() { }
    
    weak var serverdelegate:ArticlesViewModelDelegate?
    var mCurOperation = ""
    var page = 1
    var limit = 10
    var isPagination = true
    var articleListDataSource = [ArticleModel]()
    var currentTotalItem = [ArticleModel]()
    
    // ----------------------------------------------------------------------
    // ----------------- delegate method of main service ------------------
    //------------------------------------------------------------------------
    func didFetchData(responseData: Any) {
        
        if self.mCurOperation == resourceType.GETARTICLESLIST
        {
            self.serverdelegate?.didFetchArticlesData?(responseData: responseData)
        }
    }
    
    func didFailWithError(error: NSError) {
        if self.mCurOperation == resourceType.GETARTICLESLIST{
            self.serverdelegate?.didFailArticlesDataWithError?(error: error)
        }
    }
    
    // ----------------------------------------------------------------------
    // ----------------- Service Articles for  data ------------------
    //------------------------------------------------------------------------
    func getArticlesDataFromServer(methodName: String , delegate:ArticlesViewModelDelegate?) -> Void {
        self.mCurOperation = methodName
        self.serverdelegate = delegate
        super.mainServerdelegate = self
        super.getCallWithAlamofire(serverUrl: (ApiName.GETARTICLESLIST + ("page=\(page)") + ("&limit=\(limit)")))
        
    }
    
    // ----------------------------------------------------------------------
    // ----------------- Parse Articles data ------------------
    //------------------------------------------------------------------------
    
    func parseArticlesData(completion: @escaping ((Bool, String) -> Void) , responseData:Any) {
        
        let jsonData = Mapper<ArticleModel>().mapArray(JSONObject: responseData)
        if let jsonData = jsonData {
            if jsonData.count ==  0 {
                self.isPagination = false
            }
            self.currentTotalItem = jsonData
            self.articleListDataSource += jsonData
            DispatchQueue.global(qos: .background).async {
                 self.clearData()
                 self.saveInCoreDataWith(array: self.articleListDataSource)
            }
            completion(true, "")
        }
        else {
            completion(false, ErrorMsg.serverErrorMsg)
        }
    }
}

extension ArticlesViewModel {
    
    // ----------------------------------------------------------------------
    // ------------- Save the data ------------------
    //------------------------------------------------------------------------
    private func createArticleEntityFrom(dictionary: ArticleModel) -> NSManagedObject? {
        
        let context = DataManager.sharedInstance.persistentContainer.viewContext
        
        
        if let articleEntity = NSEntityDescription.insertNewObject(forEntityName: "Articles", into: context) as? Articles {
            articleEntity.id = dictionary.id ?? ""
            articleEntity.comments = String(dictionary.comments ?? 0)
            articleEntity.content = dictionary.content ?? ""
            articleEntity.createdAt = dictionary.createdAt ?? ""
            articleEntity.likes = String(dictionary.likes ?? 0)
            
            if let mediaEntity = NSEntityDescription.insertNewObject(forEntityName: "Media", into: context) as? Media {
                for objMedia in dictionary.mediaList {
                    mediaEntity.id = objMedia.id ?? ""
                    mediaEntity.blogId = objMedia.blogId ?? ""
                    mediaEntity.createdAt = objMedia.createdAt ?? ""
                    mediaEntity.image = objMedia.image ?? ""
                    mediaEntity.title = objMedia.title ?? ""
                    mediaEntity.url = objMedia.url ?? ""
                }
                articleEntity.addToMedia(mediaEntity)
            }
            
            let userEntity = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            //            {
            for objUser in dictionary.userList {
                
                userEntity.id = objUser.id ?? ""
                userEntity.blogId = objUser.blogId ?? ""
                userEntity.createdAt = objUser.createdAt ?? ""
                userEntity.about = objUser.about ?? ""
                userEntity.avatar = objUser.avatar ?? ""
                userEntity.city = objUser.city ?? ""
                userEntity.designation = objUser.designation ?? ""
                userEntity.lastname = objUser.lastname ?? ""
                userEntity.name = objUser.name ?? ""
                //               }
                articleEntity.addToUser(userEntity)
            }
            
            return articleEntity
        }
        return nil
    }
    
    // ----------------------------------------------------------------------
    // -----------fetch the record from core data -----------
    //------------------------------------------------------------------------
    
    func getArticlesDataFromCoreData () -> [ArticleModel]? {
        var listDataSource = [ArticleModel]()
        if let articlesList =   self.fetchObjects() as? [Articles] {
            articlesList.forEach { (articlesObj) in
                
                // map media List data
                var mediaList = [ArticleMediaModel]()
                if let saveMediaList = articlesObj.media?.allObjects as? [Media] {
                    saveMediaList.forEach { (mediaObj) in
                        let obj = ArticleMediaModel(id: mediaObj.id, blogId: mediaObj.blogId, createdAt: mediaObj.createdAt, image: mediaObj.image, title: mediaObj.title, url: mediaObj.url)
                        mediaList.append(obj)
                    }
                }
                
                // map user List data
                var userList = [ArticleUserModel]()
                if let saveUserList = articlesObj.user?.allObjects as? [User] {
                    saveUserList.forEach { (userObj) in
                        let obj = ArticleUserModel(id: userObj.id, blogId: userObj.blogId, createdAt: userObj.createdAt, name: userObj.name, avatar: userObj.avatar, lastname: userObj.lastname, city: userObj.city, designation: userObj.designation, about: userObj.about)
                        userList.append(obj)
                    }
                }
                
                let mainObj = ArticleModel(id: articlesObj.id, content: articlesObj.content, comments: Int(articlesObj.comments ?? ""), likes: Int(articlesObj.likes ?? ""), userList: userList, mediaList: mediaList, createdAt: articlesObj.createdAt)
                listDataSource.append(mainObj)
            }
        }
        
        
        return listDataSource
    }
    
    
    func fetchObjects() -> [NSManagedObject]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Articles")
        
        // Add Sort Descriptor
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let records = try DataManager.sharedInstance.persistentContainer.viewContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for record in records {
                print(record.value(forKey: "id") ?? "no name")
            }
            return records
            
        } catch {
            print(error)
            return nil
        }
    }
    
    private func saveInCoreDataWith(array: [ArticleModel]) {
        _ = array.map{self.createArticleEntityFrom(dictionary: $0)}
        
        do {
            try DataManager.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    // ----------------------------------------------------------------------
    // ------------- Clear the data ------------------
    //------------------------------------------------------------------------
    private func clearData() {
        do {
            
            let context = DataManager.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Articles.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                DataManager.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
}


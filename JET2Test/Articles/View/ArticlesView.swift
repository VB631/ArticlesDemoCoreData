//
//  ArticlesView.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import UIKit
import CoreData

class ArticlesView: AppMainVc,ArticlesViewModelDelegate {
    
    
    //-----------------------------------
    //MARK:- Outlet
    //-----------------------------------
    @IBOutlet weak var tblArticle: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    lazy var listDataSource :ArticlesListDataSource = ArticlesListDataSource(table: self.tblArticle)
    
    var isApiCall = true
    var isOffLine = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doInitialize()
        
    }
// ---------------------------------------------------
//    MARK: - User Function
//----------------------------------------------------
    func doInitialize() {
        // -- Reset the data ---
        ArticlesViewModel.sharedInstance.articleListDataSource.removeAll()
        ArticlesViewModel.sharedInstance.page = 1
        ArticlesViewModel.sharedInstance.currentTotalItem.removeAll()
        // -- call the Api ---
        self.getArticleListData()
    }
    
    
    
//-----------------------------------------------------------------------------
 //MARK:- Article API call -------------------------
//-----------------------------------------------------------------------------
    func getArticleListData(){
        
        // CHECK INTERNET CONNECTION
        Comman.objAppDelegate.checkInternet { [weak self](isInternet) in
            if isInternet {
                self?.isOffLine = false
                DispatchQueue.main.async {
                    // Api call for get Articles data from server
                    if (self?.isApiCall ?? true) {
                        self?.isApiCall = false
                        self?.startSpinner()
                        ArticlesViewModel.sharedInstance.getArticlesDataFromServer(methodName: resourceType.GETARTICLESLIST, delegate: self ?? nil) }
                }
            } else {
                // Get the data from local DB
                print("offline")
               self?.isOffLine = true
               self?.tblArticle.delegate = self
               self?.tblArticle.dataSource = self?.listDataSource
               self?.listDataSource.data.value = ArticlesViewModel.sharedInstance.getArticlesDataFromCoreData() ?? [ArticleModel]()
                self?.tblArticle.reloadData()
            }
        }
        
    }
    
//-----------------------------------------------------------------------------
 //MARK:-  Article Service delegate -----------
//-----------------------------------------------------------------------------
    func didFetchArticlesData(responseData:Any) ->  Void {
        ArticlesViewModel.sharedInstance.parseArticlesData(completion: { [weak self](isSuccess,message) in
            DispatchQueue.main.async {
                self?.stopSpinner()
                if isSuccess {
                    self?.tblArticle.delegate = self
                    self?.tblArticle.dataSource = self?.listDataSource
                   self?.listDataSource.data.value = ArticlesViewModel.sharedInstance.articleListDataSource
                
                    self?.tblArticle.reloadData()
                }
                else {
                    self?.showAlert(message: message, title: ErrorMsg.serverErrorTitle)
                }
            }
            
            }, responseData: responseData)
        
    }
    
    func didFailArticlesDataWithError(error:NSError) -> Void {
        super.stopSpinner()
        self.showAlert(message: ErrorMsg.serverErrorMsg, title: ErrorMsg.serverErrorTitle)
    }
}

//--------------------------------------------------------------
 //MARK:- Delegate Method for table view
//---------------------------------------------------------------
extension ArticlesView :UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // --- logic for Pagination  ----
        
        if ((indexPath.row ==  ArticlesViewModel.sharedInstance.articleListDataSource.count - 1) && (ArticlesViewModel.sharedInstance.currentTotalItem.count >= ArticlesViewModel.sharedInstance.limit)){
            if (ArticlesViewModel.sharedInstance.isPagination && !(self.isOffLine)){
                ArticlesViewModel.sharedInstance.page +=  1
                super.startSpinner()
                ArticlesViewModel.sharedInstance.getArticlesDataFromServer(methodName: resourceType.GETARTICLESLIST, delegate: self)
            }
        }
    }
}


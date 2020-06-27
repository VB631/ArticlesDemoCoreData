//
//  ArticlesListDataSource.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import UIKit
import SDWebImage

class ArticlesListDataSource:GenericDataSource<ArticleModel>, UITableViewDataSource {
    
    var tblList:UITableView?
      
      init(table:UITableView)
      {
          super.init()
         self.tblList = table
      }
    
    //--------------------------------------------------------------
    //MARK:- dataSource Method for table view
    //---------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return self.data.value.count
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "TimeLineCell") as? TimeLineCell else {
            return UITableViewCell()
        }
        cell.articleObject = self.data.value[indexPath.row]
        return cell
       
    }
    
}

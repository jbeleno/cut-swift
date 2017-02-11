//
//  NoticiasModel.swift
//  app-cut
//
//  Created by Juan Beleño Díaz on 9/02/17.
//  Copyright © 2017 Juan Beleño Díaz. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NoticiasModel {
    let paramOK = "OK"
    let paramStatus = "status"
    let paramPosts = "publicaciones"
    let argOffset = "offset"
    let linkNoticias = "http://52.27.16.14/cut/feed/ver"
    let errorMessage = "Por favor, verifica tu conexión a internet."
    let internalErrorMessage = "Estamos teniendo algunos problemas en nuestros servidores, intenta de nuevo en algunos minutos."
    
    var offset = 0;
    var datasource = NSMutableArray()
    
    init(){
        
    }
    
    func getDataSource() -> NSMutableArray{
        return datasource
    }
    
    func populateWithDataSource(table:UITableView, lblMessage:UILabel){
        
        let params = [
            argOffset : offset
        ]
        
        Alamofire.request(linkNoticias, method: .post, parameters: params).responseJSON{
            response in
            switch response.result {
                case .success(let JSON):
                    table.refreshControl?.endRefreshing()
                    
                    let response = JSON as! NSDictionary
                
                    if let status = response.object(forKey: self.paramStatus) as? String{
                        if status == self.paramOK {
                        
                            let noticias = response.object(forKey: self.paramPosts) as! NSArray
                        
                            for noticia in noticias{
                                self.datasource.add(noticia)
                            }
                        
                            self.offset += 1
                            table.reloadData()
                        }else {
                            if(self.offset == 0){
                                lblMessage.text = self.errorMessage
                                table.backgroundView = lblMessage
                                table.separatorStyle = UITableViewCellSeparatorStyle.none
                            }
                        }
                    }else {
                        if(self.offset == 0){
                            lblMessage.text = self.errorMessage
                            table.backgroundView = lblMessage
                            table.separatorStyle = UITableViewCellSeparatorStyle.none
                        }
                    }
                case .failure:
                    table.refreshControl?.endRefreshing()
                    if(self.offset == 0){
                        lblMessage.text = self.errorMessage
                        table.backgroundView = lblMessage
                        table.separatorStyle = UITableViewCellSeparatorStyle.none
                    }
            }
        };
    }

    func clearDataSource(table:UITableView){
        self.offset = 0
        datasource.removeAllObjects()
        table.reloadData()
    }
    
}

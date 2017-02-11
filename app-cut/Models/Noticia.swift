//
//  Noticia.swift
//  app-cut
//
//  Created by Juan Beleño Díaz on 9/02/17.
//  Copyright © 2017 Juan Beleño Díaz. All rights reserved.
//

import Foundation
import SwiftyJSON

struct NoticiaListItem{
    let url: String
    let titulo: String
    let tiempo: String
    let imagen: String
    
    init?(json: JSON){
        guard
            let url = json["url"].string,
            let titulo = json["titulo"].string,
            let tiempo = json["tiempo"].string,
            let imagen = json["imagen"].string
            else{
                return nil
        }
        
        self.url = url
        self.titulo = titulo
        self.tiempo = tiempo
        self.imagen = imagen
    }
}

struct NoticiaList {
    let list: [NoticiaListItem]
    
    init?(json: JSON) {
        guard let  noticiasData = json["publicaciones"].array else {
            return nil
        }
        
        self.list = noticiasData.flatMap(NoticiaListItem.init)
    }
}

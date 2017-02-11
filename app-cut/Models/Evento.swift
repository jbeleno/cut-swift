//
//  Evento.swift
//  app-cut
//
//  Created by Juan Beleño Díaz on 11/02/17.
//  Copyright © 2017 Juan Beleño Díaz. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Evento{
    let titulo: String
    let descripcion: String
    let agenda: String
    let imagen: String
    
    init?(json: JSON){
        guard
            let titulo = json["titulo"].string,
            let descripcion = json["descripcion"].string,
            let agenda = json["agenda"].string,
            let imagen = json["imagen"].string
            else{
                return nil
        }
        
        self.titulo = titulo
        self.descripcion = descripcion
        self.agenda = agenda
        self.imagen = imagen
    }
}

struct EventoListItem{
    let id: String
    let titulo: String
    let descripcion: String
    let tiempo: String
    let imagen: String
    
    init?(json: JSON){
        guard
            let id = json["id"].string,
            let titulo = json["titulo"].string,
            let descripcion = json["descripcion"].string,
            let tiempo = json["tiempo"].string,
            let imagen = json["imagen"].string
            else{
                return nil
        }
        
        self.id = id
        self.titulo = titulo
        self.descripcion = descripcion
        self.tiempo = tiempo
        self.imagen = imagen
    }
}

struct EventoList {
    let list: [EventoListItem]
    
    init?(json: JSON) {
        guard let  noticiasData = json["eventos"].array else {
            return nil
        }
        
        self.list = noticiasData.flatMap(EventoListItem.init)
    }
}

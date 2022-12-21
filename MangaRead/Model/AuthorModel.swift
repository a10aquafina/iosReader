//
//  AuthorModel.swift
//  MangaRead
//
//  Created by Apple on 25/10/2021.
//

import Foundation
import RealmSwift

class Author: Object {
    
    @objc dynamic var NameTruyen : String = ""
    @objc dynamic var Status : String = ""
    @objc dynamic var Author : String = ""
    
    override class func primaryKey() -> String? {
        return "NameTruyen"
    }
}

class TitleAuthor: NSObject {
    
    var athor:[Author] = [Author]()
    
}

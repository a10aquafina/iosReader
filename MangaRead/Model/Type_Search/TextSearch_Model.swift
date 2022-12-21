//
//  TextSearch_Model.swift
//  MangaRead
//
//  Created by Apple on 15/12/2021.
//

import Foundation
import RealmSwift

class Children: Object {
    @objc dynamic var linkImage : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var link : String = ""
    @objc dynamic var type : String = ""
    override class func primaryKey() -> String? {
        return "title"
    }
}

class Pardent: Object {
    @objc dynamic var title : String = ""
    var listCon:[Children] = [Children]()
    override class func primaryKey() -> String? {
        return "title"
    }
}



class Datoke: NSObject {
    
    var list:[Pardent] = [Pardent]()
    
}

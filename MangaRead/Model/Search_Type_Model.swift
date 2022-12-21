//
//  Search_Type_Model.swift
//  MangaRead
//
//  Created by Apple on 14/12/2021.
//

import Foundation
import RealmSwift

class Search_Type_Model: Object {                 // dang xu ly
    @objc dynamic var linkimage : String = ""
    @objc dynamic var TenTruyen : String = ""
    @objc dynamic var link : String = ""
    @objc dynamic var Tacgia : String = ""
    override class func primaryKey() -> String? {
        return "TenTruyen"
    }
}

class SearchShow: NSObject {
    
    var list:[Search_Type_Model] = [Search_Type_Model]()
    
}

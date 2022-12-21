//
//  TypeModel.swift
//  MangaRead
//
//  Created by Apple on 05/12/2021.
//

import Foundation
import RealmSwift

class TypeModel: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var link : String = ""
    override class func primaryKey() -> String? {
        return "title"
    }
}


class Type_Model_Contructor: NSObject {
    
    var TypeM:[TypeModel] = [TypeModel]()
    
}

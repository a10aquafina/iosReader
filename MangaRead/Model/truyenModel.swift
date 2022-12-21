//
//  truyenModel.swift
//  MangaRead
//
//  Created by Apple on 11/10/2021.
//

import Foundation
import RealmSwift

class truyenModel: Object {                 // dang xu ly
    @objc dynamic var linkimage : String = ""
    @objc dynamic var cao : String = ""
    @objc dynamic var rong : String = ""
    override class func primaryKey() -> String? {
        return "linkimage"
    }
}

class truyenReadModel: NSObject {
    
    var listImagepopular:[truyenModel] = [truyenModel]()
    
}

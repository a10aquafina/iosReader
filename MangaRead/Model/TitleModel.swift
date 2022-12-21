//
//  TitleModel.swift
//  MangaRead
//
//  Created by Apple on 12/10/2021.
//


import Foundation
import RealmSwift

class linkImage: Object {
    
    @objc dynamic var linkimag : String = ""
    override class func primaryKey() -> String? {
        return "linkimag"
    }
}


class linkImageChapter: NSObject {
    
    var linkdetailImage:[linkImage] = [linkImage]()
    
}

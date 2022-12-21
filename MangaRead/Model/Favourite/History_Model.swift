//
//  History_Model.swift
//  MangaRead
//
//  Created by Apple on 14/12/2021.
//

import Foundation
import RealmSwift

class History_Model: Object {
    @objc dynamic var Title: String = ""
    @objc dynamic var Link: String = ""
    @objc dynamic var linkImage: String = ""
    
    
    convenience init(Title: String, Link: String,linkImage : String) {
        self.init()
        self.Title = Title
        self.Link = Link
        self.linkImage = linkImage
        
    }
}

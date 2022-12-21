//
//  FavouriteModel.swift
//  MangaRead
//
//  Created by Apple on 23/11/2021.
//


import Foundation
import RealmSwift

class FavouriteModel: Object {
    @objc dynamic var Title: String = ""
    @objc dynamic var Link: String = ""
    @objc dynamic var linkImage: String = ""
    @objc dynamic var Author: String = ""
    @objc dynamic var count: Int = 0
    
    convenience init(Title: String, Link: String,linkImage : String,Author: String,count: Int) {
        self.init()
        self.Title = Title
        self.Link = Link
        self.linkImage = linkImage
        self.Author = Author
        self.count = count
    }
}

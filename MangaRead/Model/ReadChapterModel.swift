//
//  ReadChapterModel.swift
//  MangaRead
//
//  Created by Apple on 26/10/2021.
//


import Foundation
import RealmSwift

class ReadChapter: Object {
    @objc dynamic var linkChapter : String = ""
    @objc dynamic var Chapter : String = ""
    @objc dynamic var UpdateTime : String = ""
    override class func primaryKey() -> String? {
        return "Chapter"
    }
}

class Read: NSObject {
    
    var listchapter:[ReadChapter] = [ReadChapter]()
    
}

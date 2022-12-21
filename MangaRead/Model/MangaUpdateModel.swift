//
//  MangaUpdateModel.swift
//  MangaRead
//
//  Created by Apple on 04/10/2021.
//

import Foundation
import RealmSwift

class MangaPopularUpdateModel: Object {             // da xu ly
    @objc dynamic var linkDetail : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var imageCover : String = ""

    override class func primaryKey() -> String? {
        return "linkDetail"
    }
}

//class PopularMangaModel: Object {
//    @objc dynamic var linkDetail : String = ""
//    @objc dynamic var title : String = ""
//    @objc dynamic var imageCover : String = ""
//    @objc dynamic var titleChapter : String = ""
//    @objc dynamic var linkDetailChapter : String = ""
//
//    override class func primaryKey() -> String? {
//        return "linkDetail"
//    }
//}

class LastestChapterModel: Object {                 // dang xu ly
    @objc dynamic var linkDetailchapter : String = ""
    @objc dynamic var titlechapter : String = ""
    
    override class func primaryKey() -> String? {
        return "linkDetailchapter"
    }
}

class LastestTitleUpdateModel: Object {             // dnag xu ly
    @objc dynamic var linkDetail : String = ""
    @objc dynamic var title : String = ""
    var listChapter:[LastestChapterModel] = [LastestChapterModel]()
    override class func primaryKey() -> String? {
        return "linkDetail"
    }
}

class MangaReaderHomeModel: NSObject {
    var listPopularUpdate:[MangaPopularUpdateModel] = [MangaPopularUpdateModel]()
    var listTiltleLastestManga:[LastestTitleUpdateModel] = [LastestTitleUpdateModel]()
    
    var listChapterManga:[LastestChapterModel] = [LastestChapterModel]()
    
//    var listPoplarManga:[PopularMangaModel] = [PopularMangaModel]()
}

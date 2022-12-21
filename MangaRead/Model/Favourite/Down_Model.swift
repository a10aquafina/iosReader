//
//  Down_Model.swift
//  MangaRead
//
//  Created by Apple on 29/11/2021.
//


import Foundation
import RealmSwift


class DownModel: Object {
    @objc dynamic var TenChap: String = ""
    @objc dynamic var TenChuyen: String = ""
    @objc dynamic var link: String = ""
    @objc dynamic var Author: String = ""
    
    convenience init(TenChap: String, TenChuyen: String,link : String,Author: String) {
        self.init()
        self.TenChap = TenChap
        self.TenChuyen = TenChuyen
        self.link = link
        self.Author = Author
       
    }
}

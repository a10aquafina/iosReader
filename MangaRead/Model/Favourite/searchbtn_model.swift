//
//  searchbtn_model.swift
//  MangaRead
//
//  Created by Apple on 14/12/2021.
//

import Foundation
import RealmSwift


class SearchBtn_Model: Object {
    @objc dynamic var TextSearch: String = ""
    
    convenience init(TextSearch: String) {
        self.init()
        self.TextSearch = TextSearch
       
       
    }
}

//
//  Search_Type_Service.swift
//  MangaRead
//
//  Created by Apple on 14/12/2021.
//

import Foundation
import SwiftSoup
import SwiftyJSON


class loadSearch {
     static func loadsearch(linkPage:String,closure: @escaping (_ response: SearchShow?, _ error: Error?) -> Void) {

        
        var listSearch:[Search_Type_Model] = [Search_Type_Model]()
        var search:SearchShow = SearchShow()
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.1.2 Safari/603.3.8"]
        let session = URLSession.shared
        let url = URL(string: linkPage )
        let request = NSMutableURLRequest(url: url!)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) -> Void in

            var usedEncoding = String.Encoding.utf8 // Some fallback value
            if let encodingName = response?.textEncodingName {
                let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding(encodingName as CFString))
                if encoding != UInt(kCFStringEncodingInvalidId) {
                    usedEncoding = String.Encoding(rawValue: encoding)
                }
            }
            if let data = data{
                if let myString = NSString(data: data, encoding: usedEncoding.rawValue) {
//                    print(myString)
                    do {
                        //________APPS
                        let doc: Document = try SwiftSoup.parse(myString as String)
                        let elements = try doc.getAllElements()


                        for element in elements {
                            switch element.tagName() {
                            
                            case "div":
                                if try element.className() == "d39"{
                                    
                                    
                                    let tableCl = try element.select("table")
                                    let tbody = try tableCl.select("tbody")
                                    let trClass = try tbody.select("tr")
                                    let tdClass = try trClass.select("td")
                                   
                                    var data: Search_Type_Model = Search_Type_Model()
                                        
                                    let td3Chuaanh = try tdClass.get(1).select("td")
                                    let td3Chuaten = try tdClass.get(2).select("td")
                                    data.linkimage =  try td3Chuaanh.select("div").attr("data-src")
                                    let divchualink = try td3Chuaten.select("div")
                                    data.link = try divchualink.get(0).select("a").attr("href")
                                    data.TenTruyen = try divchualink.get(0).select("a").text()
                                    data.Tacgia = try divchualink.get(2).text()
                                    listSearch.append(data)
                                    search.list.append(contentsOf: listSearch)
                                }
                                
                            
                            default:
                                break
                            }

                        }

                    } catch let error {
                        print("Error: \(error)")
                    }
                } else {
                    print("failed to decode data")
                }

                search.list = listSearch
                closure(search, nil)
            }

        })
        task.resume()
    }
}

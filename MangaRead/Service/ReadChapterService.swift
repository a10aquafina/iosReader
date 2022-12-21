//
//  ReadChapterService.swift
//  MangaRead
//
//  Created by Apple on 26/10/2021.
//

import UIKit

import SwiftSoup
import SwiftyJSON


class loadListChapter {
     static func loadchapter(linkPage:String,closure: @escaping (_ response: Read?, _ error: Error?) -> Void) {

        
        var listchapter:[ReadChapter] = [ReadChapter]()
        var chap:Read = Read()
        
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
                            
                            case "table":
                                if try element.className() == "d48"{
                                    let tbody = try element.select("tbody")
                                    let trClass = try tbody.select("tr")
                                    for it in trClass{
                                        if try it.className() != "d49"{
                                            let tdClass = try it.select("td")
                                            let chapa:ReadChapter = ReadChapter()
                                            chapa.UpdateTime = try tdClass.get(1).text()
                                            let aClass = try tdClass.select("a")
                                            for item in aClass{
                                                chapa.Chapter = try item.text()
                                                chapa.linkChapter = try item.attr("href")
                                            }
                                            listchapter.append(chapa)
                                            chap.listchapter.append(contentsOf: listchapter)
                                            
                                        }
                                    
                                    }
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

                chap.listchapter = listchapter
                closure(chap, nil)
            }

        })
        task.resume()
    }
}

//
//  TruyenService.swift
//  MangaRead
//
//  Created by Apple on 11/10/2021.
//


import Foundation
import SwiftSoup
import SwiftyJSON

class LoadTruyenService {
     static func loadTruyen(linkPage:String,closure: @escaping (_ response: truyenReadModel?, _ error: Error?) -> Void) {
        
        var listImg1:[truyenModel] = [truyenModel]()
        
        var listtruyen:truyenReadModel = truyenReadModel()
        
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
                            case "img":
                                if try element.className() == "img-loading"{
                                    
                                    let truyen:truyenModel = truyenModel()
                                    truyen.linkimage = try element.attr("data-src")
                                    truyen.rong = try element.attr("width")
                                    truyen.cao = try element.attr("height")
                                    listImg1.append(truyen)
                                    listtruyen.listImagepopular.append(contentsOf: listImg1)
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
                
                listtruyen.listImagepopular = listImg1
                closure(listtruyen, nil)
            }

        })
        task.resume()
    }
}

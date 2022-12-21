//
//  TypeService.swift
//  MangaRead
//
//  Created by Apple on 05/12/2021.
//

import Foundation
import SwiftSoup
import SwiftyJSON


class loadType {
     static func loadtype(linkPage:String,closure: @escaping (_ response: Type_Model_Contructor?, _ error: Error?) -> Void) {

        
        var list:[TypeModel] = [TypeModel]()
        var listtype:Type_Model_Contructor = Type_Model_Contructor()
        
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
                            
                            case "ul":
                                if try element.className() == "d50"{
                                    let liClass = try element.select("li")
                                    let aClass = try liClass.select("a")
                                    
                                    for item in aClass{
                                        let type1: TypeModel = TypeModel()
                                        type1.link = try item.attr("href")
                                        
                                        type1.title = try item.text()
                                        
                                        list.append(type1)
                                        listtype.TypeM.append(contentsOf: list)
                                        
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

                listtype.TypeM = list
                closure(listtype, nil)
            }

        })
        task.resume()
    }
}

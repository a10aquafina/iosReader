//
//  SearCh_Service.swift
//  MangaRead
//
//  Created by Apple on 15/12/2021.
//

import Foundation
import SwiftSoup
import SwiftyJSON

class LoadTextService {
    static func loadText(linkPage:String,closure: @escaping (_ response: Datoke?, _ error: Error?) -> Void) {
        
        
        var listcon:[Children] = [Children]()
        var listto:[Pardent] = [Pardent]()
        
        var Contruct:Datoke = Datoke()
        
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
                                if try element.className() == "d52 d61"{
                                    var i = 0
                                    let divClass = try element.select("div")
                                    for item in divClass{
                                        if try item.className() == "d62"{
                                            let divd62 = try item.select("div")
                                            let div = try divd62.select("div")
                                            let parent:Pardent = Pardent()
                                            listcon.removeAll()
                                            for it in div{
                                                if try it.className() == "d63"{
                                                    parent.title = try it.text()
                                                }
                                                if try it.className() == "d64"{
                                                    var divcon64 = try it.select("div")
                                                    var divdat = try divcon64.select("div")
                                                    for idsd in divdat{
                                                        if try idsd.className() == "d66"{
                                                            var chil: Children = Children()
                                                            var divads = try idsd.select("div")
                                                            chil.link = try divads.get(1).select("a").attr("href")
                                                            chil.title = try divads.get(1).select("a").text()
                                                            chil.type = try divads.text()
                                                            chil.linkImage = try divcon64.attr("data-src")
                                                            listcon.append(chil)
                                                        }
                                                    }
                                                }
                                            }
                                            parent.listCon.append(contentsOf: listcon)
                                            listto.append(parent)
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
                
                Contruct.list = listto
                
                closure(Contruct, nil)
            }
            
        })
        task.resume()
    }
}

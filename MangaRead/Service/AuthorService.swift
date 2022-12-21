//
//  AuthorService.swift
//  MangaRead
//
//  Created by Apple on 25/10/2021.
//

import Foundation
import SwiftSoup
import SwiftyJSON


class loadAuthor {
     static func loadTitle(linkPage:String,closure: @escaping (_ response: TitleAuthor?, _ error: Error?) -> Void) {

        
        var listAuthor:[Author] = [Author]()
        var authorbig:TitleAuthor = TitleAuthor()
        
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
                                if try element.className() == "d41"{
                                    let tbody = try element.select("tbody")
                                    let trClass = try tbody.select("tr")
                                    let tdClass = try trClass.select("td")
                                    
                                    let author:Author = Author()
                                    author.NameTruyen = try trClass.select("td").get(1).text()
                                    author.Status = try trClass.select("td").get(7).text()
                                    author.Author = try trClass.select("td").get(9).text()
                                    listAuthor.append(author)
                                    authorbig.athor.append(contentsOf: listAuthor)
                                    
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

                authorbig.athor = listAuthor
                closure(authorbig, nil)
            }

        })
        task.resume()
    }
}

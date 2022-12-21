//
//  TitleService.swift
//  MangaRead
//
//  Created by Apple on 12/10/2021.
//




import Foundation
import SwiftSoup
import SwiftyJSON

class LoadTitleService {
     static func loadTitle(linkPage:String,closure: @escaping (_ response: linkImageChapter?, _ error: Error?) -> Void) {

        
        var listImage:[linkImage] = [linkImage]()
        var Imageimg:linkImageChapter = linkImageChapter()
        
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
                                if try element.className() == "d38"{
                                    let imgClass = try element.select("img")
                                    let linkIma:linkImage = linkImage()
                                    linkIma.linkimag = try imgClass.attr("src")
                                    listImage.append(linkIma)
                                    Imageimg.linkdetailImage.append(linkIma)
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

                Imageimg.linkdetailImage = listImage
                closure(Imageimg, nil)
            }

        })
        task.resume()
    }
}

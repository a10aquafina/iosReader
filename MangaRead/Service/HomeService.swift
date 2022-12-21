//
//  HomeService.swift
//  MangaRead
//
//  Created by Apple on 02/10/2021.
//


import Foundation
import SwiftSoup
import SwiftyJSON

class LoadMangaPopularUpdateModelService {
     static func loadMangaReadHome(linkPage:String,closure: @escaping (_ response: MangaReaderHomeModel?, _ error: Error?) -> Void) {
        var listPopularUpdate:[MangaPopularUpdateModel] = [MangaPopularUpdateModel]()
        var listTiltleLastestManga:[LastestTitleUpdateModel] = [LastestTitleUpdateModel]()
        var listChapterManga:[LastestChapterModel] = [LastestChapterModel]()
        
        var HomeList:MangaReaderHomeModel = MangaReaderHomeModel()
        
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
                                if try element.className() == "d40"{
                                    let PopularMangaUpdate:MangaPopularUpdateModel = MangaPopularUpdateModel()
                                    
                                var aClass = try element.select("a")
                                PopularMangaUpdate.linkDetail = try aClass.attr("href")
                                var imgClass = try aClass.select("img")
                                PopularMangaUpdate.imageCover = try imgClass.attr("src")
                                PopularMangaUpdate.title = try imgClass.attr("alt")
                                listPopularUpdate.append(PopularMangaUpdate)
                                }
                                //chapter
                                if try element.className() == "d52"{
                                    let div53 = try element.select("div")
                                    let adiv53Class = try div53.select("a")
                                    let title:LastestTitleUpdateModel = LastestTitleUpdateModel()
                                    for item in adiv53Class{
                                        if try item.className() != "d57" && item.className() != "d58"{
                                    title.linkDetail = try item.attr("href")
                                    title.title = try item.text()}
                                    }
                                    let ulClass = try element.select("ul")
                                    let liClass = try ulClass.select("li")
                                    let aClaass = try liClass.select("a")
                                    for item in aClaass{
                                        if try item.className() == "d57"{
                                    let chapter:LastestChapterModel = LastestChapterModel()
                                        chapter.linkDetailchapter = try item.attr("href")
                                        chapter.titlechapter = try item.text()
                                        listChapterManga.append(chapter)
                                            
                                            title.listChapter.append(chapter)
                                            
                                        }
                                    }
                                    listTiltleLastestManga.append(title)
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
                
                HomeList.listPopularUpdate = listPopularUpdate
                HomeList.listTiltleLastestManga = listTiltleLastestManga
                HomeList.listChapterManga = listChapterManga
               
                closure(HomeList, nil)
            }

        })
        task.resume()
    }
}

//
//  InforViewController.swift
//  MangaRead
//
//  Created by Apple on 25/10/2021.
//

import UIKit
import Kingfisher
import RealmSwift

class InforViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var url:String = "https://mangareader.tv/"
    var HomeList : linkImageChapter = linkImageChapter()
    var AuthorList:TitleAuthor = TitleAuthor()
    var Chapterlist:Read = Read()
    
    var link :String!
    var bienImage:UIImage!
    var NameTruyen:String!
    
    
    var listImg1: truyenReadModel = truyenReadModel()
    @IBOutlet var ViewTong: UIView!
    @IBOutlet weak var InforCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadTitleService.loadTitle(linkPage: url + link ){ repond,error in
            if let HomeList = repond{
                self.HomeList = HomeList
                DispatchQueue.main.async {
                    self.InforCollection.reloadData()
                }
            }
        }
        loadAuthor.loadTitle(linkPage: url + link ){ repond,error in
            if let AuthorList = repond{
                self.AuthorList = AuthorList
                DispatchQueue.main.async {
                    self.InforCollection.reloadData()
                }
            }
        }
        loadListChapter.loadchapter(linkPage: url + link ){ repond,error in
            if let Chapterlist = repond{
                self.Chapterlist = Chapterlist
                DispatchQueue.main.async {
                    self.InforCollection.reloadData()
                }
            }
        }
        
        let realm = try! Realm()
        let list = realm.objects(FavouriteModel.self)
        ViewTong.backgroundColor = UIColor(red: 13/255, green: 7/255, blue: 8/255, alpha: 1)
        InforCollection.delegate = self
        InforCollection.dataSource = self
        
        InforCollection.backgroundColor = UIColor(red: 13/255, green: 7/255, blue: 8/255, alpha: 1)
        
        let image = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        InforCollection.register(image, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        let infor = UINib(nibName: "InforMangaCollectionViewCell", bundle: nil)
        InforCollection.register(infor, forCellWithReuseIdentifier: "InforMangaCollectionViewCell")
        
        let btn = UINib(nibName: "buttonCollectionViewCell", bundle: nil)
        InforCollection.register(btn, forCellWithReuseIdentifier: "buttonCollectionViewCell")
        
        let chap = UINib(nibName: "collctionCollectionViewCell", bundle: nil)
        InforCollection.register(chap, forCellWithReuseIdentifier: "collctionCollectionViewCell")
        
        
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return HomeList.linkdetailImage.count
        }
        else if section == 1{
            return AuthorList.athor.count
        }
        else if section == 2{
            return 1
        }
        return Chapterlist.listchapter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell0 = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath as IndexPath) as! ImageCollectionViewCell
            
            let linkimag = URL(string: url + HomeList.linkdetailImage[0].linkimag)
            
            let processor = DownsamplingImageProcessor(size: cell0.Image.bounds.size)
                |> RoundCornerImageProcessor(cornerRadius: 0)
            cell0.Image.kf.indicatorType = .activity
            cell0.Image.kf.setImage(
                with: linkimag,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    cell0.ImageGray.image =  cell0.Image.image?.noir
                    
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
                cell0.ViewImage.backgroundColor = .clear
                cell0.ViewImageGray.backgroundColor = .clear
                
                cell0.ImageGray.layer.cornerRadius = cell0.ImageGray.frame.height*0.55
                cell0.ImageGray.layer.maskedCorners = [.layerMinXMaxYCorner]
                cell0.Image.layer.cornerRadius = cell0.Image.frame.height*0.65
                cell0.Image.layer.maskedCorners = [.layerMinXMaxYCorner]
                cell0.ImageGray.roundCorners(corners: [.topLeft], radius: 30)
            }
            return cell0
        }
        
        else if indexPath.section == 1{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "InforMangaCollectionViewCell", for: indexPath as IndexPath) as! InforMangaCollectionViewCell
            cell1.LabelName.textColor = .white
            cell1.NhapName.textColor = .white
            cell1.Status.textColor = .white
            cell1.NhapStatus.textColor = .white
            cell1.Author.textColor = .white
            cell1.NhapAuthor.textColor = .white
            
            cell1.LabelName.text = "Name: "
            cell1.NhapName.text = AuthorList.athor[indexPath.row].NameTruyen
            cell1.Status.text = "Status: "
            cell1.NhapStatus.text = AuthorList.athor[indexPath.row].Status
            cell1.Author.text = "Author: "
            cell1.NhapAuthor.text = AuthorList.athor[indexPath.row].Author
            return cell1
        }
        //MARK:---
        else if indexPath.section == 2{
            let btn = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCollectionViewCell", for: indexPath as IndexPath) as! buttonCollectionViewCell
            
            btn.Share.addTarget(self, action: #selector(Share), for: .touchUpInside)
            btn.Timdo.addTarget(self, action: #selector(Favotire), for: .touchUpInside)
            let realm = try! Realm()
            let data = FavouriteModel()
            let list = realm.objects(FavouriteModel.self).toArray(ofType: FavouriteModel.self)
            
            for item in list{
                for i in AuthorList.athor{
                    if item.Title == i.NameTruyen{
                        btn.Timdo.setImage(UIImage(named: "timdo"), for: .normal)
                    }
                    else{
                        btn.Timdo.setImage(UIImage(named: "fav"), for: .normal)
                    }
                }
            }
            
            
            
            return btn
        }
        //MARK:---
        
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "collctionCollectionViewCell", for: indexPath as IndexPath) as! collctionCollectionViewCell
        
        cell2.LabelChapter.text = Chapterlist.listchapter[indexPath.row].Chapter
        cell2.LabelChapter.textColor = .white
        cell2.Down.addTarget(self, action: #selector(Down), for: .touchUpInside)
        let realm = try! Realm()
        let data = DownModel()
        let list = realm.objects(DownModel.self).toArray(ofType: DownModel.self)
        
        for item in list{
            for i in Chapterlist.listchapter{
                if item.link == i.linkChapter{
                    cell2.Down.setImage(UIImage(named: "fav"), for: .normal)
                }
                else{
                    cell2.Down.setImage(UIImage(named: "down"), for: .normal)
                }
            }
        }
        
            return cell2
        
    }
    @objc func Favotire(sender:UIButton){
        
        let realm = try! Realm()
        let data = FavouriteModel()
        data.Title = AuthorList.athor[0].NameTruyen
        data.linkImage = url + HomeList.linkdetailImage[0].linkimag
        data.Link = link
        data.count = Chapterlist.listchapter.count
        data.Author = AuthorList.athor[0].Author
        var check = 0

            let dataFilters = realm.objects(FavouriteModel.self).toArray(ofType: FavouriteModel.self)
            for item in dataFilters{
                if item.Title == data.Title{
                    check = 1
                    break
                }
            }
            if check == 0{
                try! realm.write {
                            realm.add(data)
                    print("Them fav success ")
                    }
                
            }
            else{
                try! realm.write {
                    
                    let datacheck = realm.objects(FavouriteModel.self).filter("Title = %@ AND Link = %@ AND linkImage = %@ AND count = %@", AuthorList.athor[0].NameTruyen, link, url + HomeList.linkdetailImage[0].linkimag, Chapterlist.listchapter.count)
                    realm.delete(datacheck)
                    print("Delete success ")
                }
            }
        InforCollection.reloadData()
    }
    
//    @objc func XoaFav(sender:UIButton){
//        let realm = try! Realm()
//        let data = FavouriteModel()
//        func deleteData(Title: String, Link: String,linkImage :String,count:Int) {
//                let dataFilters = realm.objects(FavouriteModel.self).filter("Title = %@ AND birthdate = %@ AND linkImage = %@ AND count = %@", Title, Link, linkImage, count)
//                try! realm.write {
//                    realm.delete(dataFilters)
//                }
//            }
//        print("Delete success ")
//        InforCollection.reloadData()
//
//    }
    
    @objc func Down(sender:UIButton){
        let realm = try! Realm()
        let data = DownModel()
        data.TenChap = Chapterlist.listchapter[sender.tag].Chapter
        data.TenChuyen = AuthorList.athor[sender.tag].NameTruyen
        data.link = Chapterlist.listchapter[sender.tag].linkChapter
       
        try! realm.write {
                    realm.add(data)
                }
        print("Down success ")
        InforCollection.reloadData()
    }
    
    @objc func Share(sender:UIButton){
        let text = "Share for every one"
        let URL:NSURL = NSURL(string: "https://www.google.co.in")!
        let vc = UIActivityViewController(activityItems: [text,URL], applicationActivities: [])
        if let popoverControler = vc.popoverPresentationController{
            popoverControler.sourceView = self.view
            popoverControler.sourceRect = self.view.bounds
        }
        self.present(vc, animated: true,completion:  nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //MARK:
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            
        }
        else if indexPath.section == 1{
            
        }
        else if indexPath.section == 2{
            
        }
        else{
            switch indexPath.row {
            case indexPath.row:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TruyenViewController") as! TruyenViewController
                vc.navigationController?.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .overFullScreen
                vc.link = Chapterlist.listchapter[indexPath.row].linkChapter
                self.present(vc, animated: true)
            default:
                print()
            }
        }
        
        
        
    }
    
    
    
    
    
   
//MARK:
}
extension InforViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: 300)
        }
        
        else if indexPath.section == 1{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: 150)
        }
        
        else if indexPath.section == 2{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: 30)
        }
        
        else if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 20)
    }
}

//
//  Home1ViewController.swift
//  MangaRead
//
//  Created by Apple on 20/10/2021.
//

import UIKit

class Home1ViewController: UIViewController {
    var HomeList : MangaReaderHomeModel = MangaReaderHomeModel()
    
    var url:String = "https://mangareader.tv/"
    @IBOutlet weak var HomeCollection :UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadMangaPopularUpdateModelService.loadMangaReadHome(linkPage: url  ){ repond,error in
            if let HomeList = repond{
                
                DispatchQueue.main.async {
                    self.HomeCollection.reloadData()
                    self.HomeList = HomeList
                }
            }
        }
        
        
        HomeCollection.delegate = self
        HomeCollection.dataSource = self
        HomeCollection.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        
        let labelpo = UINib(nibName: "LabelPopularCollectionViewCell", bundle: nil)
        HomeCollection.register(labelpo, forCellWithReuseIdentifier: "LabelPopularCollectionViewCell")
        
        let nib = UINib(nibName: "PopularCollectionViewCell", bundle: nil)
        HomeCollection.register(nib, forCellWithReuseIdentifier: "PopularCollectionViewCell")
        
//        let page = UINib(nibName: "PageViewCollectionViewCell", bundle: nil)
//        HomeCollection.register(page, forCellWithReuseIdentifier: "PageViewCollectionViewCell")
        
        let labellast = UINib(nibName: "LabelLastCollectionViewCell", bundle: nil)
        HomeCollection.register(labellast, forCellWithReuseIdentifier: "LabelLastCollectionViewCell")
        
        let nib1 = UINib(nibName: "LastestChapterCollectionViewCell", bundle: nil)
        HomeCollection.register(nib1, forCellWithReuseIdentifier: "LastestChapterCollectionViewCell")
    }
    
    
}
extension Home1ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
            return 1
        }
        else if section == 2{
            return 1
        }
//        else if section == 3{
//            return 1
//        }
        return HomeList.listTiltleLastestManga.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
        if indexPath.section == 0{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelPopularCollectionViewCell", for: indexPath as IndexPath) as! LabelPopularCollectionViewCell
            return cell1
        }
        else if indexPath.section == 1{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath as IndexPath) as! PopularCollectionViewCell
            
            return cell2
            
        }
        
//        else if indexPath.section == 2{
//            let page = collectionView.dequeueReusableCell(withReuseIdentifier: "PageViewCollectionViewCell", for: indexPath as IndexPath) as! PageViewCollectionViewCell
//
//
//            page.pageControl.numberOfPages = HomeList.listPopularUpdate.count
//            page.pageControl.currentPage = PopularCollectionViewCell.pageindex
//
//
//            return page
//
//        }
        else if indexPath.section == 2{
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelLastCollectionViewCell", for: indexPath as IndexPath) as! LabelLastCollectionViewCell
            return cell3
        }
        
        let cell4 = collectionView.dequeueReusableCell(withReuseIdentifier: "LastestChapterCollectionViewCell", for: indexPath as IndexPath) as! LastestChapterCollectionViewCell
        cell4.LableTitleChapter.text = HomeList.listTiltleLastestManga[indexPath.row].title
        cell4.indexPath1 = indexPath
        cell4.ChapterList = HomeList
        return cell4

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3{
            switch indexPath.row {
            case indexPath.row:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "InforViewController") as! InforViewController
                vc.navigationController?.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .overFullScreen
                vc.link = HomeList.listTiltleLastestManga[indexPath.row].linkDetail
                
                self.present(vc, animated: true)
            default:
                print()
            }
        }
    }
    
    
    
    
    
    
}
extension Home1ViewController: UICollectionViewDelegateFlowLayout {
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
                return CGSize(width: UIScreen.main.bounds.width, height: 40)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: 40)
        }
        
        else if indexPath.section == 1{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: 300)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: 300)
        }
        
//        else if indexPath.section == 2{
//            if UIDevice.current.userInterfaceIdiom == .pad{
//                return CGSize(width: UIScreen.main.bounds.width, height: 40)
//            }
//            return CGSize(width: UIScreen.main.bounds.width, height: 40)
//        }
        
        else if indexPath.section == 2{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: 40)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: 40)
        }

       
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: 200)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: 150)
       
        
    }
}


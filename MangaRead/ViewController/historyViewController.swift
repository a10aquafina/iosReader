//
//  historyViewController.swift
//  MangaRead
//
//  Created by Apple on 24/11/2021.
//

import UIKit
import RealmSwift

class historyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    var url:String = "https://mangareader.tv/"
    @IBOutlet weak var Save: UIButton!
    @IBOutlet weak var History: UIButton!
    @IBOutlet weak var Favourite: UIButton!
    @IBOutlet weak var HistoryCollection: UICollectionView!
    var indexSection:Int = 0
    var isSection :Bool = true
    @IBOutlet var ViewTong: UIView!
    var currentIndex: Int = 0
    let realm = try! Realm()
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var abcView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HistoryCollection.delegate = self
        HistoryCollection.dataSource = self
        HistoryCollection.backgroundColor = .clear
        ViewTong.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        HistoryCollection.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        abcView.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        viewTop.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        let nib = UINib(nibName: "favCollectionViewCell", bundle: nil)
        HistoryCollection.register(nib, forCellWithReuseIdentifier: "favCollectionViewCell")
        
        let nib1 = UINib(nibName: "hisCollectionViewCell", bundle: nil)
        HistoryCollection.register(nib1, forCellWithReuseIdentifier: "hisCollectionViewCell")
        
        let nib2 = UINib(nibName: "saveCollectionViewCell", bundle: nil)
        HistoryCollection.register(nib2, forCellWithReuseIdentifier: "saveCollectionViewCell")
        // Do any additional setup after loading the view.
        Favourite.setTitleColor(UIColor.white, for: .normal)
        History.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
        Save.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HistoryCollection.reloadData()
    }
    
    
    //MARK:----

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1}
        else if section == 1{
            return 1
        }
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.section == 0{

            let cell0 = collectionView.dequeueReusableCell(withReuseIdentifier: "favCollectionViewCell", for: indexPath as IndexPath) as! favCollectionViewCell
            cell0.favouCollection.reloadData()
            return cell0
        }

        else if indexPath.section == 1{
           
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "hisCollectionViewCell", for: indexPath as IndexPath) as! hisCollectionViewCell
            cell1.HisCollection.reloadData()
            return cell1
        }
        else {
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "saveCollectionViewCell", for: indexPath as IndexPath) as! saveCollectionViewCell
            cell2.SaveCollection.reloadData()
            return cell2
        }
       
    }
    
    @IBAction func Favourite(_ sender: Any) {
        HistoryCollection.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        Favourite.setTitleColor(UIColor.white, for: .normal)
        History.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
        Save.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
        print("fav")
    }
    
    @IBAction func History(_ sender: Any) {
        HistoryCollection.scrollToItem(at: IndexPath(item: 0, section: 1), at: .centeredHorizontally, animated: true)
        History.setTitleColor(UIColor.white, for: .normal)
        Favourite.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
        Save.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
        print("his")
    }
    @IBAction func Save(_ sender: Any) {
        HistoryCollection.scrollToItem(at: IndexPath(item: 0, section: 2), at: .centeredHorizontally, animated: true)
        Save.setTitleColor(UIColor.white, for: .normal)
        Favourite.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
        History.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
        
        print("save")
            }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("datoke\(scrollView.contentOffset.x)")
        if scrollView.contentOffset.x == 0.0{
            
            Favourite.setTitleColor(UIColor.white, for: .normal)
            History.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
            Save.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
//            HistoryCollection.reloadData()

        }
        else if scrollView.contentOffset.x <= 428.0{
            
            History.setTitleColor(UIColor.white, for: .normal)
            Favourite.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
            Save.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
//            HistoryCollection.reloadData()
        }
        else {
            Save.setTitleColor(UIColor.white, for: .normal)
            Favourite.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
            History.setTitleColor(UIColor(red: 135/255, green: 114/255, blue: 150/255, alpha: 1), for: .normal)
//            HistoryCollection.reloadData()
        }

    }
//    //MARK:------
    
}


extension historyViewController : UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            if section == 0{
                return CGFloat(30)
                
            }
            else if section == 0{
                return CGFloat(30)
                
            }
            return CGFloat(10)
        }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: view.frame.width, height: view.frame.height)
            }
            return CGSize(width: view.frame.width, height: view.frame.height/1.3)
        }
        else if indexPath.section == 1{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            return CGSize(width: view.frame.width, height: view.frame.height/1.3)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        return CGSize(width: view.frame.width, height: view.frame.height/1.3)
    }
        
}
    
    
        
    

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}

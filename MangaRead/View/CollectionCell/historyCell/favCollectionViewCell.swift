//
//  favCollectionViewCell.swift
//  MangaRead
//
//  Created by Apple on 09/12/2021.
//

import UIKit
import RealmSwift
class favCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var index:Int = 0
    let realm = try! Realm()
    
    
    @IBOutlet weak var favouCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favouCollection.delegate = self
        favouCollection.dataSource = self
        
        favouCollection.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        let labelpo = UINib(nibName: "favChildernCollectionViewCell", bundle: nil)
        favouCollection.register(labelpo, forCellWithReuseIdentifier: "favChildernCollectionViewCell")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = FavouriteModel()
        let list = realm.objects(FavouriteModel.self)
        
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favChildernCollectionViewCell", for: indexPath as IndexPath) as! favChildernCollectionViewCell
        let data = FavouriteModel()
        let list1 = realm.objects(FavouriteModel.self).toArray(ofType: FavouriteModel.self)
        cell.NameTruyen.text = list1[indexPath.row].Title
        cell.soChap.text = String(list1[indexPath.row].count) + " Chapter"
        cell.Image.getImageFromURL(urlString: list1[indexPath.row].linkImage)
        cell.Author.text = list1[indexPath.row].Author
        
        cell.NameTruyen.textColor = .white
        cell.soChap.textColor = .white
        cell.Author.textColor = .white
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case indexPath.row:
            
            if let parentVC = self.parentViewController  as? historyViewController {
                let realm = try! Realm()
                let data = FavouriteModel()
                let list = realm.objects(FavouriteModel.self).toArray(ofType: FavouriteModel.self)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "InforViewController") as! InforViewController
            vc.navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .overFullScreen
                vc.link = list[indexPath.row].Link
            parentVC.present(vc, animated: false)
                
            }
        default:
            print()
        }
    }
}
extension favCollectionViewCell: UICollectionViewDelegateFlowLayout {
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
        
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/5)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/7)
        }
}
        
        

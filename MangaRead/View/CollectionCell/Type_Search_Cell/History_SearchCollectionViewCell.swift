//
//  History_SearchCollectionViewCell.swift
//  MangaRead
//
//  Created by Apple on 07/12/2021.
//

import UIKit
import RealmSwift

class History_SearchCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    @IBOutlet weak var Collection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Collection.delegate = self
        Collection.dataSource = self
        let labelpo = UINib(nibName: "CollhisCollectionViewCell", bundle: nil)
        Collection.register(labelpo, forCellWithReuseIdentifier: "CollhisCollectionViewCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let realm = try! Realm()
        let data = SearchBtn_Model()
        return realm.objects(SearchBtn_Model.self).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CollhisCollectionViewCell", for: indexPath as IndexPath) as! CollhisCollectionViewCell
        let realm = try! Realm()
        let data = SearchBtn_Model()
        let list = realm.objects(SearchBtn_Model.self).toArray(ofType: SearchBtn_Model.self)
        cell1.textsearch.text = list[indexPath.row].TextSearch
        cell1.textsearch.textColor = .white
        return cell1
    }

}
extension History_SearchCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: 10)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: 20)
        }
}

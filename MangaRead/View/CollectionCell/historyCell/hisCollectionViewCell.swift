//
//  hisCollectionViewCell.swift
//  MangaRead
//
//  Created by Apple on 03/12/2021.
//

import UIKit
import RealmSwift

class hisCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    let realm = try! Realm()
    @IBOutlet weak var HisCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        HisCollection.delegate = self
        HisCollection.dataSource = self
        HisCollection.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        let labelpo = UINib(nibName: "HisChildrenCollectionViewCell", bundle: nil)
        HisCollection.register(labelpo, forCellWithReuseIdentifier: "HisChildrenCollectionViewCell")
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = History_Model()
        let list = realm.objects(History_Model.self)
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HisChildrenCollectionViewCell", for: indexPath as IndexPath) as! HisChildrenCollectionViewCell
        let data = History_Model()
        let list = realm.objects(History_Model.self).toArray(ofType: History_Model.self)
        cell.TenTruyen.text = list[indexPath.row].Title
        
        cell.TenTruyen.textColor = .white
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case indexPath.row:
            if let parentVC = self.parentViewController  as? historyViewController {
                let realm = try! Realm()
                let data = History_Model()
                let list = realm.objects(History_Model.self).toArray(ofType: History_Model.self)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TruyenViewController") as! TruyenViewController
            vc.navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .overFullScreen
                vc.link = list[indexPath.row].Link
                vc.labeltitle = list[indexPath.row].Title
            parentVC.present(vc, animated: false)
                
            }
        default:
            print()
        }
    }
    
    

}
extension hisCollectionViewCell: UICollectionViewDelegateFlowLayout {
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
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/10)
        }
}

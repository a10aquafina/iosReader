//
//  saveCollectionViewCell.swift
//  MangaRead
//
//  Created by Apple on 30/11/2021.
//

import UIKit
import RealmSwift

class saveCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    let realm = try! Realm()
    
    @IBOutlet weak var SaveCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        SaveCollection.delegate = self
        SaveCollection.dataSource = self
        SaveCollection.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        let labelpo = UINib(nibName: "saveChildrenCollectionViewCell", bundle: nil)
        SaveCollection.register(labelpo, forCellWithReuseIdentifier: "saveChildrenCollectionViewCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = DownModel()
        let list = realm.objects(DownModel.self)
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "saveChildrenCollectionViewCell", for: indexPath as IndexPath) as! saveChildrenCollectionViewCell
        let data = DownModel()
        let list1 = realm.objects(DownModel.self).toArray(ofType: DownModel.self)
        cell.NameTruyen.text = list1[indexPath.row].TenChuyen
        cell.TenChap.text = list1[indexPath.row].TenChap
        cell.NameTruyen.textColor = .white
        cell.TenChap.textColor = .white
        return cell
    }
    //MARK:--
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case indexPath.row:
            if let parentVC = self.parentViewController  as? historyViewController {
                let realm = try! Realm()
                let data = DownModel()
                let list = realm.objects(DownModel.self).toArray(ofType: DownModel.self)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TruyenViewController") as! TruyenViewController
            vc.navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .overFullScreen
                vc.link = list[indexPath.row].link
                vc.labeltitle = list[indexPath.row].TenChuyen
            parentVC.present(vc, animated: false)
                
            }
        default:
            print()
        }
    }
    

}
extension saveCollectionViewCell: UICollectionViewDelegateFlowLayout {
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

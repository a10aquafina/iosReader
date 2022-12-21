//
//  Type_SearchCollectionViewCell.swift
//  MangaRead
//
//  Created by Apple on 07/12/2021.
//

import UIKit

class Type_SearchCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var TypeChuyen:Type_Model_Contructor = Type_Model_Contructor()
    var url = "https://mangareader.tv/genre"
    
    @IBOutlet weak var TypeCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadType.loadtype(linkPage: url  ){ repond,error in
            if let HomeList = repond{
                self.TypeChuyen = HomeList
                DispatchQueue.main.async {
                    self.TypeCollection.reloadData()
                }
            }
        }
        TypeCollection.backgroundColor = UIColor(red: 13/255, green: 7/255, blue: 28/255, alpha: 1)
        TypeCollection.delegate = self
        TypeCollection.dataSource = self
        
        let timkiem = UINib(nibName: "CollecCollectionViewCell", bundle: nil)
        TypeCollection.register(timkiem, forCellWithReuseIdentifier: "CollecCollectionViewCell")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TypeChuyen.TypeM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollecCollectionViewCell", for: indexPath as IndexPath) as! CollecCollectionViewCell
        cell.LabelType.backgroundColor = .clear
        cell.LabelType.text = TypeChuyen.TypeM[indexPath.row].title
        cell.LabelType.textColor = .white
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case indexPath.row:
            if let parentVC = self.parentViewController  as? SearchViewController {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "AfterSearchViewController") as! AfterSearchViewController
                vc.navigationController?.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .overFullScreen
                vc.url = TypeChuyen.TypeM[indexPath.row].link
                parentVC.present(vc, animated: true)
            }
        default:
            print()
        }
    }
    
}
extension Type_SearchCollectionViewCell: UICollectionViewDelegateFlowLayout {
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
                return CGSize(width: UIScreen.main.bounds.width,height: 20)
            }
            return CGSize(width: UIScreen.main.bounds.width/3, height: 20)
            }
}

//
//  SearchTextCollectionViewCell.swift
//  MangaRead
//
//  Created by Apple on 15/12/2021.
//

import UIKit

class SearchTextCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var index1:IndexPath = [0, 0]
    var datok : Datoke = Datoke()
    
    @IBOutlet weak var Collection: UICollectionView!
    @IBOutlet weak var Ttieude: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Collection.delegate = self
        Collection.dataSource = self
        Collection.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        
        let nib = UINib(nibName: "imagedatCollectionViewCell", bundle: nil)
        Collection.register(nib, forCellWithReuseIdentifier: "imagedatCollectionViewCell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "imagedatCollectionViewCell", for: indexPath as IndexPath) as! imagedatCollectionViewCell
        cell1.index1 = index1
        cell1.index2 = indexPath
        cell1.datok = datok
        return cell1
    }
    

}
extension SearchTextCollectionViewCell: UICollectionViewDelegateFlowLayout {
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
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/2 + 20)
        }
}

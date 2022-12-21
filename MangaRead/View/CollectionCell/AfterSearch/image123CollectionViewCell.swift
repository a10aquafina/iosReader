//
//  imageCollectionViewCell.swift
//  MangaRead
//
//  Created by Apple on 15/12/2021.
//

import UIKit

class image123CollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var index2:IndexPath = [0, 0]
    var datok : Datoke = Datoke()
    @IBOutlet weak var conCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        conCollection.delegate = self
        conCollection.dataSource = self
        conCollection.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        
        let nib = UINib(nibName: "conCollectionViewCell", bundle: nil)
        conCollection.register(nib, forCellWithReuseIdentifier: "conCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "conCollectionViewCell", for: indexPath as IndexPath) as! conCollectionViewCell
        
        return cell1
    }
    


}
extension image123CollectionViewCell: UICollectionViewDelegateFlowLayout {
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

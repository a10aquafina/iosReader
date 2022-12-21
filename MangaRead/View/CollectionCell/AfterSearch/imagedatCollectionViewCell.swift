//
//  imagedatCollectionViewCell.swift
//  MangaRead
//
//  Created by Apple on 15/12/2021.
//

import UIKit

class imagedatCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var index1:IndexPath = [0, 0]
    var index2:IndexPath = [0, 0]
    var url = "https://mangareader.tv/"
    var datok : Datoke = Datoke()
    @IBOutlet weak var Collection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Collection.delegate = self
        Collection.dataSource = self
        Collection.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        
        let nib = UINib(nibName: "conCollectionViewCell", bundle: nil)
        Collection.register(nib, forCellWithReuseIdentifier: "conCollectionViewCell")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datok.list[index1.row].listCon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "conCollectionViewCell", for: indexPath as IndexPath) as! conCollectionViewCell
        cell1.Image.getImageFromURL(urlString: url + datok.list[index1.row].listCon[indexPath.row].linkImage)
        cell1.titile.text = datok.list[index1.row].listCon[indexPath.row].title
        cell1.type.text = datok.list[index1.row].listCon[indexPath.row].type
        return cell1
    }
    
    
}
extension imagedatCollectionViewCell: UICollectionViewDelegateFlowLayout {
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
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/6)
        }
}

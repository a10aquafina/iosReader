//
//  LastestChapterCollectionViewCell.swift
//  MangaRead
//
//  Created by Apple on 20/10/2021.
//

import UIKit
import RealmSwift

class LastestChapterCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var url:String = "https://mangareader.tv/"
    var ChapterList: MangaReaderHomeModel = MangaReaderHomeModel()
    var indexPath1:IndexPath = [0, 0]
    @IBOutlet weak var ChapterCollection: UICollectionView!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var LableTitleChapter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        image.image = UIImage(named: "truyen")
        ChapterCollection.delegate = self
        ChapterCollection.dataSource = self
        ChapterCollection.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        let nib = UINib(nibName: "LatCollectionViewCell", bundle: nil)
        ChapterCollection.register(nib, forCellWithReuseIdentifier: "LatCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatCollectionViewCell", for: indexPath as IndexPath) as! LatCollectionViewCell
        
        
        cell.LabelChapter.text = ChapterList.listTiltleLastestManga[indexPath1.row].listChapter[indexPath.item].titlechapter
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case indexPath.row:
            if let parentVC = self.parentViewController  as? Home1ViewController {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TruyenViewController") as! TruyenViewController
                    vc.navigationController?.pushViewController(vc, animated: true)
                    vc.modalPresentationStyle = .overFullScreen
                
                    vc.link = ChapterList.listTiltleLastestManga[indexPath1.row].listChapter[indexPath.item].linkDetailchapter
                vc.labeltitle = ChapterList.listTiltleLastestManga[indexPath1.row].listChapter[indexPath.item].titlechapter
    //MARK:--Realm
                let realm = try! Realm()
                let data = History_Model()
                data.Title =  ChapterList.listTiltleLastestManga[indexPath1.row].listChapter[indexPath.item].titlechapter
                data.Link = ChapterList.listTiltleLastestManga[indexPath1.row].listChapter[indexPath.item].linkDetailchapter
                try! realm.write {
                            realm.add(data)
                    print("Them history success ")
                    }
                parentVC.present(vc, animated: false)
                
            }
        default:
            print()
        }
    }

}

extension LastestChapterCollectionViewCell: UICollectionViewDelegateFlowLayout {
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
                return CGSize(width: collectionView.frame.width, height: 30)
            }
            return CGSize(width: collectionView.frame.width, height: 20)
        
    }
        
       
    
}

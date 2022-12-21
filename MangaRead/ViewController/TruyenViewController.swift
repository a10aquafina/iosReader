//
//  TruyenViewController.swift
//  MangaRead
//
//  Created by Apple on 11/10/2021.
//

import UIKit
import Kingfisher
class TruyenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var ti_le = 0.0
    @IBOutlet weak var TenTruyen: UILabel!
    var url:String = "https://mangareader.tv/"
    var link:String!
    var labeltitle:String!
    var listImg1: truyenReadModel = truyenReadModel()
    @IBOutlet weak var truyenCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "TruyenCollectionViewCell", bundle: nil)
        truyenCollection.register(nib, forCellWithReuseIdentifier: "TruyenCollectionViewCell")
        truyenCollection.delegate = self
        truyenCollection.dataSource = self
        truyenCollection.backgroundColor = UIColor(red: 0.16, green: 0.02, blue: 0.27, alpha: 1)
        LoadTruyenService.loadTruyen(linkPage: url + link ){ repond,error in
            if let listImg = repond{
                self.listImg1 = listImg
                DispatchQueue.main.async {

                    self.truyenCollection.reloadData()
                }
            }
        }
        TenTruyen.text = labeltitle
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImg1.listImagepopular.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TruyenCollectionViewCell", for: indexPath) as! TruyenCollectionViewCell

        cell.imageChap.getImageFromURL(urlString:  listImg1.listImagepopular[indexPath.row].linkimage)
        let myclor = UIColor.white
        cell.layer.borderWidth = 2
        cell.layer.borderColor = myclor.cgColor
        cell.layer.cornerRadius = 10
        let linkimag = URL(string: listImg1.listImagepopular[indexPath.row].linkimage)
        
        let processor = DownsamplingImageProcessor(size: cell.imageChap.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 0)
        cell.imageChap.kf.indicatorType = .activity
        cell.imageChap.kf.setImage(
            with: linkimag,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                cell.imageChap.image =  cell.imageChap.image
                self.ti_le = Double(CGFloat(cell.imageChap.image?.size.height ?? 0.0) /  CGFloat(cell.imageChap.image?.size.width ?? 0))
                
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        return cell
    }

    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension TruyenViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return CGFloat(10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cao:Int = 0
        var rong:Int = 1
        for i in 0...10000{
            if String(i) == String(listImg1.listImagepopular[indexPath.row].cao){
                cao = i
            }
        }
        for j in 0...10000{
            if String(j) == String(listImg1.listImagepopular[indexPath.row].rong){
                rong = j
            }
        }
        print(cao)
        print(rong)
            let width = collectionView.bounds.width/1.1
        let height = CGFloat(Int(width)*cao/rong)
        
            
            return CGSize(width: width, height: height)
        }


}

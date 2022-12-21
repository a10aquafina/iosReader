//
//  PopularCollectionViewCell.swift
//  MangaRead
//
//  Created by Apple on 20/10/2021.
//

import UIKit
import Kingfisher

class PopularCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    var timer:Timer!
    var pageindex:Int = 0
    var HomeList : MangaReaderHomeModel = MangaReaderHomeModel()
    var url:String = "https://mangareader.tv/"
    static var index: Int!
    let layout = Cus()
    var itemW :CGFloat{
        return UIScreen.main.bounds.size.width * 0.4
    }
    var itemH: CGFloat{
        return itemW * 1.5
    }
    
    @IBOutlet weak var pplarCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        LoadMangaPopularUpdateModelService.loadMangaReadHome(linkPage: url  ){ repond,error in
            if let HomeList = repond{
                self.HomeList = HomeList
                DispatchQueue.main.async {
                    self.pplarCollection.reloadData()
                    self.pplarCollection.scrollToItem(at: IndexPath(row: 500, section: 0), at: .centeredHorizontally, animated: false)
                }
            }
        }
        
        pplarCollection.delegate = self
        pplarCollection.dataSource = self
        
        let nib = UINib(nibName: "pplarCollectionViewCell", bundle: nil)
        pplarCollection.register(nib, forCellWithReuseIdentifier: "pplarCollectionViewCell")
        pplarCollection.backgroundColor = .clear
//        starttimer()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if HomeList.listPopularUpdate.count > 0{
            return 1000}
        return 0
    }
    func  starttimer() {
            timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(nextindex), userInfo: nil, repeats: true)
        }
        @objc func nextindex(){
            if pageindex >= HomeList.listPopularUpdate.count{
                pageindex = 0
            }
            pageindex = pageindex + 1
            pplarCollection.scrollToItem(at: IndexPath(item: pageindex, section: 0), at: .centeredHorizontally, animated: true)
            
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pplarCollectionViewCell", for: indexPath as IndexPath) as! pplarCollectionViewCell
        let myColor : UIColor = UIColor.white
        cell.LabelTitle.text = HomeList.listPopularUpdate[indexPath.row % HomeList.listPopularUpdate.count].title
        cell.LabelTitle.textColor = .white
        cell.LabelTitle.lineBreakMode = .byTruncatingTail
        cell.LabelTitle.numberOfLines = 2
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2
        cell.layer.borderColor = myColor.cgColor
        cell.backgroundColor = UIColor(red: 52/255, green: 24/255, blue: 122/255, alpha: 1)
        
        
        let linkimag = URL(string: url + HomeList.listPopularUpdate[indexPath.row % HomeList.listPopularUpdate.count].imageCover)
        
        let processor = DownsamplingImageProcessor(size: cell.ImagePopular.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 0)
        cell.ImagePopular.kf.indicatorType = .activity
        cell.ImagePopular.kf.setImage(
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
                cell.ImagePopular.image =  cell.ImagePopular.image
                
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
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
                    vc.link = HomeList.listPopularUpdate[indexPath.row % HomeList.listPopularUpdate.count].linkDetail
                    vc.labeltitle = HomeList.listPopularUpdate[indexPath.row % HomeList.listPopularUpdate.count].title
                    parentVC.present(vc, animated: false)
                
            }
            
        default:
            print()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.pplarCollection?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWith = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
    }
    
    
    }
extension PopularCollectionViewCell: UICollectionViewDelegateFlowLayout {
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
                return CGSize(width: collectionView.frame.width/2.8, height: collectionView.frame.height)
            }
        return CGSize(width: collectionView.frame.width/2.3, height: collectionView.frame.height)
        
    }
}
    

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

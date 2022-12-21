//
//  AfterSearchViewController.swift
//  MangaRead
//
//  Created by Apple on 08/12/2021.
//

import UIKit
import  Kingfisher
class AfterSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var abc = "https://mangareader.tv/"
    var url:String!
    var HomeListabc : SearchShow = SearchShow()
    
    @IBOutlet weak var ViewTop: UIView!
    @IBOutlet weak var Collecti: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Collecti.delegate = self
        Collecti.dataSource = self
        Collecti.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        ViewTop.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        
        let labelpo = UINib(nibName: "CollectionViewCell", bundle: nil)
        Collecti.register(labelpo, forCellWithReuseIdentifier: "CollectionViewCell")
        
        loadSearch.loadsearch(linkPage: abc + url  ){ repond,error in
            if let HomeListabc = repond{
                DispatchQueue.main.async {
                    self.HomeListabc = HomeListabc
                    self.Collecti.reloadData()
                }
            }
        }
       
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeListabc.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath) as! CollectionViewCell
        
        let linkimag = URL(string: abc + HomeListabc.list[indexPath.row].linkimage)
        
        let processor = DownsamplingImageProcessor(size: cell1.iamge.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 0)
        cell1.iamge.kf.indicatorType = .activity
        cell1.iamge.kf.setImage(
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
                cell1.iamge.image =  cell1.iamge.image
                
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        cell1.tentruyen.text = HomeListabc.list[indexPath.row].TenTruyen
        cell1.tacgia.text = HomeListabc.list[indexPath.row].Tacgia
        cell1.tentruyen.textColor = .white
        cell1.tacgia.textColor = .white
        return cell1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case indexPath.row:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "InforViewController") as! InforViewController
            vc.navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .overFullScreen
            vc.link = HomeListabc.list[indexPath.row].link
            
            self.present(vc, animated: true)
        default:
            print()
        }
    }
    
    

}
extension AfterSearchViewController: UICollectionViewDelegateFlowLayout {
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

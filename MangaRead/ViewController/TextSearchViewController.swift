//
//  TextSearchViewController.swift
//  MangaRead
//
//  Created by Apple on 15/12/2021.
//

import UIKit

class TextSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var viewtop: UIView!
    var datok : Datoke = Datoke()
    var keysearch:String = "all"
    @IBOutlet weak var Collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        LoadTextService.loadText(linkPage: "https://mangareader.tv/search/?w=\(keysearch)&w="  ){ repond,error in
            if let datok = repond{
                DispatchQueue.main.async {
                    self.Collection.reloadData()
                    self.datok = datok
                }
            }
        }
        // Do any additional setup after loading the view.
        Collection.delegate = self
        Collection.dataSource = self
        Collection.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        viewtop.backgroundColor = UIColor(red: 41/255, green: 6/255, blue: 69/255, alpha: 1)
        let nib = UINib(nibName: "SearchTextCollectionViewCell", bundle: nil)
        Collection.register(nib, forCellWithReuseIdentifier: "SearchTextCollectionViewCell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datok.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchTextCollectionViewCell", for: indexPath as IndexPath) as! SearchTextCollectionViewCell
        cell1.Ttieude.text = datok.list[indexPath.row].title
        cell1.datok = datok
        cell1.index1 = indexPath
        return cell1
    }
    
    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    

}
extension TextSearchViewController: UICollectionViewDelegateFlowLayout {
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
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3 - 10)
        }
}

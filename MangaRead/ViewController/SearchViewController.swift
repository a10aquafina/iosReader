//
//  SearchViewController.swift
//  MangaRead
//
//  Created by Apple on 05/12/2021.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var ViewTop: UIView!
    let realm = try! Realm()
    @IBOutlet weak var textfield: UITextField!
    var check = 0
    var high = 1
    @IBOutlet weak var Collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Collection.delegate = self
        Collection.dataSource = self
        Collection.backgroundColor = UIColor(red: 13/255, green: 7/255, blue: 28/255, alpha: 1)
        ViewTop.backgroundColor = UIColor(red: 13/255, green: 7/255, blue: 28/255, alpha: 1)
        let nib0 = UINib(nibName: "LabelTypeCollectionViewCell", bundle: nil)
        Collection.register(nib0, forCellWithReuseIdentifier: "LabelTypeCollectionViewCell")

        let nib = UINib(nibName: "Type_SearchCollectionViewCell", bundle: nil)
        Collection.register(nib, forCellWithReuseIdentifier: "Type_SearchCollectionViewCell")
        
        let nib2 = UINib(nibName: "historyCellCollectionViewCell", bundle: nil)
        Collection.register(nib2, forCellWithReuseIdentifier: "historyCellCollectionViewCell")
        
        let nib1 = UINib(nibName: "History_SearchCollectionViewCell", bundle: nil)
        Collection.register(nib1, forCellWithReuseIdentifier: "History_SearchCollectionViewCell")
        self.hideKeyboardWhenTappedAround()
        
    }
    //MARK:---
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
            return 1
        }
        else if section == 2{
            return 1
        }
        
        return 1
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        print("text \( textfield.text)")
        let realm = try! Realm()
        let data = SearchBtn_Model()
        data.TextSearch = String(textfield.text ?? "")
        try! realm.write {
                    realm.add(data)
            print("search success")
                }
        if textfield.text != nil{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TextSearchViewController") as! TextSearchViewController
        vc.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .overFullScreen
            vc.keysearch = String(textfield.text ?? "all")
        
            self.present(vc, animated: true)}
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelTypeCollectionViewCell", for: indexPath as IndexPath) as! LabelTypeCollectionViewCell
            if high == 1{
                cell.btnback.setImage(UIImage(named: "xuong"), for: .normal)}
            else{
                cell.btnback.setImage(UIImage(named: "ngang"), for: .normal)
            }
            return cell
        }
        
        else if indexPath.section == 1{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "Type_SearchCollectionViewCell", for: indexPath as IndexPath) as! Type_SearchCollectionViewCell
            
                return cell1
            
        }
        else if indexPath.section == 2{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "historyCellCollectionViewCell", for: indexPath as IndexPath) as! historyCellCollectionViewCell
            cell2.lichsutimkiem.text = "Lịch sử tìm kiếm"
            cell2.backgroundColor = UIColor(red: 13/255, green: 7/255, blue: 28/255, alpha: 1)
                return cell2
        }
        
        let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "History_SearchCollectionViewCell", for: indexPath as IndexPath) as! History_SearchCollectionViewCell
        
        cell3.backgroundColor = UIColor(red: 13/255, green: 7/255, blue: 28/255, alpha: 1)
            return cell3
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section)
        if indexPath.section == 0{
            print("xuong")
            if check == 0{
            high = 400
            Collection.reloadData()
            check = 1
            }
            else{
                high = 1
                Collection.reloadData()
                check = 0
            }
        }
        else if indexPath.section == 1{
            
            
            }
        }
        
    }
    
//MARK:--
extension SearchViewController: UICollectionViewDelegateFlowLayout {
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
        if indexPath.section == 0{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width,height: 30)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: 30)
        }
        
        else if indexPath.section == 1{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: CGFloat(high))
            }
            return CGSize(width: UIScreen.main.bounds.width, height: CGFloat(high))
        }
        
        else if indexPath.section == 2{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: 20)
            }
            return CGSize(width: UIScreen.main.bounds.width, height: 20)
        }
        
        else if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height  )
        }
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height  )
    }
}

extension SearchViewController: UITextFieldDelegate {
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

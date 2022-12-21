//
//  Cus.swift
//  MangaRead
//
//  Created by Apple on 23/11/2021.
//

import Foundation
import UIKit

class Cus: UICollectionViewFlowLayout{
    var Phanbu: CGFloat = 0.0
    var currentPage:Int = 0
    override func targetContentOffset(forProposedContentOffset pro:CGPoint,withScrollingVelocity ver:CGPoint) -> CGPoint{
        guard let cv = collectionView else { return super.targetContentOffset(forProposedContentOffset: pro, withScrollingVelocity: ver) }
        let itcont = cv.numberOfItems(inSection: 0)
        if Phanbu > cv.contentOffset.x && ver.x < 0.0{
            currentPage = max(currentPage - 1, 0)
        }
        else if Phanbu < cv.contentOffset.x && ver.x > 0.0{
            currentPage = min(currentPage + 1, 0)
        }
        let width = cv.frame.width
        let itemW = itemSize.width
        let sp = minimumLineSpacing
        
        let khoangcach2ben = (width - itemW - sp*2)/2
        let bu_lai = (itemW + sp ) * CGFloat(currentPage ) - (khoangcach2ben + sp)
        
        Phanbu = bu_lai
        return CGPoint(x: bu_lai, y: pro.y)
        
    }
}

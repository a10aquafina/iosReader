//
//  InforMangaCollectionViewCell.swift
//  MangaRead
//
//  Created by Apple on 25/10/2021.
//

import UIKit

class InforMangaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var LabelName: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var Author: UILabel!
    
    @IBOutlet weak var NhapName: UILabel!
    
    @IBOutlet weak var NhapStatus: UILabel!
    
    @IBOutlet weak var NhapAuthor: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
    }

}

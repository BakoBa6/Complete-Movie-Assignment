//
//  CollectionViewCell.swift
//  Movies Asignment
//
//  Created by bako abdullah on 2/3/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var moviePosterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionViewCorenerRadus()
    }
    //MARK: - helper methodes
    private func setCollectionViewCorenerRadus(){
        self.layer.cornerRadius = 20
    }

}

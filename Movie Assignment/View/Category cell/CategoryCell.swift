//
//  CategoryCollectionViewCell.swift
//  Movies Asignment
//
//  Created by bako abdullah on 2/5/20.
//  Copyright © 2020 bako abdullah. All rights res
import UIKit
import Kingfisher
import RxSwift
import RxCocoa
class CategoryCell:UICollectionViewCell{
    
    //MARK: - IBOutlet part
    
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    //MARK: - properties part
    var category:MovieCategory?
    var disposeBag = DisposeBag()
    
    //MARK: - view methodes part
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionViewCell()
        movieCollectionView.setDelegateAndDatasource(toObject: self)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    //MARK: - helper method part
    private func registerCollectionViewCell(){
        movieCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    
}

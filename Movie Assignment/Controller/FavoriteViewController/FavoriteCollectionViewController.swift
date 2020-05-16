//
//  FavoriteCollectionViewController.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/13/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
import Kingfisher
class FavoriteCollectionViewController: UICollectionViewController {
    //MARK: - properties part
    var favoriteMovie:FavouriteMovie?
    //MARK: - view methodes part
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewCellSize()
        registerCollectionViewCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    //MARK: - helper methodes part
    private func setCollectionViewCellSize(){
        let width = (view.frame.size.width-20)/3
        let height = view.frame.size.height/4
        collectionView.setCollectionViewCellSize(width: width, height: height)
    }
    private func registerCollectionViewCell(){
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    //MARK: - prepare for segue part
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationDetailVC = segue.destination as! MovieDetailTableViewController
        if let favoriteMovie = favoriteMovie{
            destinationDetailVC.selectedMovie = PropertySetter.SharedSetter.setMovieProperties(from: favoriteMovie)
        }
    }
}

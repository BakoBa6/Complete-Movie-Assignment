//
//  FavoriteCillectionViewController+CollectionViewDatasource Extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/13/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
// collection view data source
extension FavoriteCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let favoriteMovies = AllFavoriteMovies.sharedFavoriteMovies.favoriteMovies{
            return favoriteMovies.count
        }else{
            return 0
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favoriteMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        if let url = AllFavoriteMovies.sharedFavoriteMovies.favoriteMovies![indexPath.item].posterUrlString.convertToURL(){
            favoriteMovieCell.moviePosterImage.kf.setImage(with: url)
        }
        return favoriteMovieCell
    }
}

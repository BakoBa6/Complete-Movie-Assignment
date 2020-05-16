//
//  FavoriteCillectionViewController+CollectionViewDelegate Extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/13/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
//collectionView delegate
extension FavoriteCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.favoriteMovie = AllFavoriteMovies.sharedFavoriteMovies.favoriteMovies![indexPath.item]
        performSegue(withIdentifier: "favoriteToDetail", sender: self)
    }
}

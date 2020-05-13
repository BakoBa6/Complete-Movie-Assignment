//
//  SearchForMovieViewController+CollectionViewDelegate Extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/13/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
extension SearchForMovieViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMovie = searchResutlMovies[indexPath.item]
        performSegue(withIdentifier: "searchToDetail", sender: self)
    }
}

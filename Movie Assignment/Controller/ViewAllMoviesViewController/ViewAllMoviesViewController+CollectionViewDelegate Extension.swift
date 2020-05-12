//
//  ViewAllMoviesViewController+CollectionViewDelegate Extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/10/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
//MARK: - implementing delegate Methodes of collectionView
extension ViewAllMoviesCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMovie = category!.categoryMovies[indexPath.item]
        performSegue(withIdentifier: "ViewAllInCategoryToDetail", sender: self)
    }
}

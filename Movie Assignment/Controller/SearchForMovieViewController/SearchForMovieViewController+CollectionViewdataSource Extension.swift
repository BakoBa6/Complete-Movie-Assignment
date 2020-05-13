//
//  SearchForMovieViewController+CollectionViewdataSource Extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/13/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
extension SearchForMovieViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !searchResutlMovies.isEmpty{
            return searchResutlMovies.count
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let searchResultMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as!MovieCell
        let movie = searchResutlMovies[indexPath.item]
        if let url = movie.posterUrlString.convertToURL(){
            searchResultMovieCell.moviePosterImage.kf.setImage(with: url)
            if searchResultMovieCell.moviePosterImage.image == nil{
                searchResultMovieCell.moviePosterImage.image = #imageLiteral(resourceName: "000000H1")
            }
        }
        return searchResultMovieCell
    }  
}






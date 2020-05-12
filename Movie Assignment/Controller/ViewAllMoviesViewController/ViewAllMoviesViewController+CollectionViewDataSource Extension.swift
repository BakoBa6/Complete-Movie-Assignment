//
//  File.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/10/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//
import UIKit
//MARK: - implementing the datasource methodes of collectionView
extension ViewAllMoviesCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let category = category{
            return category.categoryMovies.count
        }else{
            return 0
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        if let url = getURLString(forIndexPath: indexPath).convertToURL(){
            movieCell.moviePosterImage.kf.setImage(with: url)
        }
        return movieCell
        
    }
    //MARK: - hepler methodes part
    private func getURLString(forIndexPath indexPath:IndexPath)->String{
        return category!.categoryMovies[indexPath.item].posterUrlString
    }
}

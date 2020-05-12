//
//  CategoryCell+CollectionViewDataSource extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/8/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
extension CategoryCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let category = category{
            return category.categoryMovies.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        print(AllCategories.sharedCategories.categories[indexPath.section].categoryTitle)
        let movieCell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        if let url = getPosterURLString(forIndexPath: indexPath)?.convertToURL(){
            movieCell.moviePosterImage.kf.setImage(with:url)
        }
        return movieCell
    }
    private func getPosterURLString(forIndexPath indexPath:IndexPath)->String?{
        if let category = category{
            return category.categoryMovies[indexPath.item].posterUrlString
        }else{
            return nil
        }
    }
}

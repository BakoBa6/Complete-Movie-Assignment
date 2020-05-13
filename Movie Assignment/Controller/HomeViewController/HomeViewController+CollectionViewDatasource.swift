//
//  HomeViewController+CollectionViewDatasource.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/8/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
extension HomeViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if selectedCategory != nil{
            return 1
        }else{
         return categories.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        categoryCell.categoryTitleLabel.text = getCategoryTitle(forIndexPath: indexPath)
        if let selectedCategory = selectedCategory{
            categoryCell.category = selectedCategory
            categoryCell.categoryTitleLabel.text = selectedCategory.categoryTitle
        }else{
            categoryCell.category = categories[indexPath.item]
            categoryCell.categoryTitleLabel.text = categories[indexPath.item].categoryTitle
        }
        categoryCell.movieCollectionView.reloadData()
        categoryCell.movieCollectionView.setCollectionViewCellSize(width: getDesiredWidth(), height: getDesiredHeight())
        categoryCell.movieCollectionView.reloadData()
        subscribeViewAllButton(forCell: categoryCell)
        subscribeCollectionViewCellTap(forCell: categoryCell)
        return categoryCell
    }
    //MARK: - helper methodes
    private func getCategoryTitle(forIndexPath indexPath:IndexPath)->String{
        return categories[indexPath.item].categoryTitle
    }
    private func getDesiredWidth()->CGFloat{
        let width = (view.frame.size.width-20)/3
        return width
    }
    private func getDesiredHeight()->CGFloat{
        let height = view.frame.size.height/4
        return height
    }
    private func subscribeViewAllButton(forCell cell:CategoryCell){
        cell.viewAllButton.rx.tap.subscribe { [weak self](_) in
            self?.selectedCategoryForViewAllMoviesInCategory = cell.category
            self?.performSegue(withIdentifier: "homeToViewAllMoviesIncategory", sender: self)
        }.disposed(by: cell.disposeBag)
    }
    private func subscribeCollectionViewCellTap(forCell cell:CategoryCell){
        cell.movieCollectionView.rx.itemSelected.subscribe(onNext: { [weak self](indexPath) in
            if let category = cell.category{
                let selectedMovieFromCollectionView = category.categoryMovies[indexPath.item]
                self?.selectedMovie = selectedMovieFromCollectionView
            }
            self?.performSegue(withIdentifier: "homeToDetail", sender: self)
        }).disposed(by: cell.disposeBag)
    }
}

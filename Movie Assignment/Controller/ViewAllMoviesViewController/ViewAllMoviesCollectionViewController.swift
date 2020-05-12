//
//  ViewAllMoviesCollectionViewController.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/10/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
import Kingfisher
class ViewAllMoviesCollectionViewController: UICollectionViewController {
    //MARK: - properties part
    var category:MovieCategory?
    var selectedMovie:Movie?
    //MARK: - view methodes part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewCellSize()
        registerCollectionViewCell()
    }
    //MARK: - helper methodes part
    private func registerCollectionViewCell(){
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    private func setCollectionViewCellSize(){
        let width = (view.frame.size.width-20)/3
        let height = view.frame.size.height/4
        collectionView.setCollectionViewCellSize(width: width, height: height)
    }
    //MARK: - prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationDetailVC = segue.destination as! MovieDetailTableViewController
        if let selectedMovie = selectedMovie{
            destinationDetailVC.selectedMovie = selectedMovie
        }
    }
    
}

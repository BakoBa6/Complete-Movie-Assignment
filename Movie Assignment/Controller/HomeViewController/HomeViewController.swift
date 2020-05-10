//
//  ViewController.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/6/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
class HomeViewController: UIViewController {
    //MARK: -  IBOutlet part
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categorySelectionButton: UIButton!
    @IBOutlet weak var categorySelectionTableView: UITableView!
    @IBOutlet weak var categorySelectionTableViewHeight: NSLayoutConstraint!
    //MARK: - properties part
    var categories:[MovieCategory] = []
    var isCategorySelectionTableViewVisible = false
    var selectedCategory:MovieCategory?
    //MARK: - view methodes part
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieData()
        registerCollectionViewCell()
        setCategoryCollectionViewSize()
        categoryCollectionView.setDelegateAndDatasource(toObject: self)
        categorySelectionTableView.setDelegateAndDatasource(toObject: self)
    }
    //MARK: - IBAction part
    
    @IBAction func categorySelectionButtonPressed(_ sender: UIButton) {
        animateCategoryselectionTableView()
    }
    //MARK: - helper methodes part
    //animating the tableView
    func animateCategoryselectionTableView(){
        isCategorySelectionTableViewVisible.nigate()
        if isCategorySelectionTableViewVisible{
            setCategorySelectionTableViewVisible()
        }
        else{
            setCategorySelectionTableViewInvisible()
        }
        
    }
    //making the tableView visible
    func setCategorySelectionTableViewVisible(){
        UIView.animate(withDuration: 0.5) {
            self.categorySelectionTableViewHeight.constant = self.categorySelectionTableView.contentSize.height
            self.view.layoutIfNeeded()
        }
    }
    // making the table view invisible
    func setCategorySelectionTableViewInvisible(){
        UIView.animate(withDuration: 0.5) {
            self.categorySelectionTableViewHeight.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    //get a movie instance
    private func getMovie(title:String,posterURL:String,overview:String, dateProduced:String,rating:String,movieId:String)->Movie{
        let movie = Movie(movieTitle: title, posterUrl: posterURL, rating: rating, overview: overview, dateProduced: dateProduced, movieId: movieId)
        return movie
    }
    //adding movie instances to category
    private func addMovieToCategory(movie: Movie?,toCategory category:MovieCategory) {
        if let movie = movie{
            category.categoryMovies.append(movie)
        }
    }
    //setting the size of collection view
    private func setCategoryCollectionViewSize(){
        let width = view.frame.size.width
        let height = width/1.5
        categoryCollectionView.setCollectionViewCellSize(width: width, height: height)
    }
    //registering collectionView custom cell
    private func registerCollectionViewCell(){
        categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
    }
    //MARK: - data loading part
    func loadMovieData(){
        //requesting data from API
        for category in AllCategories.categories{
            let parameters = URLS.returnParameters(forType: .AllMoviesURL, withValue: category.genreID)
            let url = URLS.getURLFromEnumRawValue(forType: .AllMoviesURL)
            APIRequest.sharedAPIRequest.requestData(fromUrl:url,withParameters: parameters) { [weak self](json) in
                if let json = json{
                    let categoryWithMovies = self?.parseMovieJSON(json: json, to: category)
                    if let categoryWithMovies = categoryWithMovies{
                        
                        self?.categories.append(categoryWithMovies)
                        self?.categoryCollectionView.reloadDataInMainThread()
                        self?.categorySelectionTableView.reloadInMainThread()
                    }
                }
            }
            
        }
        
    }
    
    
    private func parseMovieJSON(json:JSON,to category:MovieCategory)->MovieCategory{
        
        //parsing the data returned from api
        let categoryWithMovies = MovieCategory(genreID: category.genreID, categoryTitle: category.categoryTitle)
        JSONParser.sharedParser.parseJSON(fromJSON: json) { [weak self](json) in
            if let json = json{
                let result = json["results"]
                for i in 0 ..< result.count{
                    // movie title
                    let title = result[i]["title"].stringValue
                    // movie poster path
                    let posterPath = result[i]["poster_path"].stringValue
                    // the complete movie poster url string
                    let posterURLString = URLS.getUrlStringForEnumCase(forType: .moviePosterURL,withAdditionalValue: posterPath)
                    // movie overview
                    let overview = result[i]["overview"].stringValue
                    // date when the movie was produced
                    let dateProduced = result[i]["release_date"].stringValue
                    //movie rating
                    let rating = result[i]["vote_average"].stringValue
                    //movie id
                    let movieId = result[i]["id"].stringValue
                    //creating a movie object with above information with the help of a helper method
                    let movie = self?.getMovie(title: title, posterURL: posterURLString, overview: overview, dateProduced: dateProduced, rating: rating, movieId: movieId)
                    //adding movie to the category with help of a helper method
                    self?.addMovieToCategory(movie: movie, toCategory: categoryWithMovies)
                }
            }
        }
        
        return categoryWithMovies
        
    }
    
}

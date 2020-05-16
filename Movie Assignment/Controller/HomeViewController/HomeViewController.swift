//
//  ViewController.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/6/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
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
    var selectedCategoryForViewAllMoviesInCategory:MovieCategory?
    var selectedMovie:Movie?
    let categorySelectionTableViewConstant:CGFloat = 0.018
    private let queue = DispatchQueue(label:"appending new categories")
    
    //MARK: - view methodes part
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieData()
        registerCollectionViewCell()
        setCategoryCollectionViewCellSize()
        registerTableViewCell()
        categoryCollectionView.setDelegateAndDatasource(toObject: self)
        categorySelectionTableView.setDelegateAndDatasource(toObject: self)
    }
    //MARK: - IBAction part
    @IBAction func categorySelectionButtonPressed(_ sender: UIButton) {
        animateCategoryselectionTableView()
    }
    //MARK: - helper methodes part
    // register table view cell
    private func registerTableViewCell(){
        categorySelectionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "categorySelectionCell")
    }
    //animating the tableView
    func animateCategoryselectionTableView(){
        isCategorySelectionTableViewVisible.negate()
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
    private func setCategoryCollectionViewCellSize(){
        let width = view.frame.size.width-20
        let height = view.frame.size.height/3
        categoryCollectionView.setCollectionViewCellSize(width: width, height: height)
    }
    //registering collectionView custom cell
    private func registerCollectionViewCell(){
        categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
    }
    //MARK: - prepre for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToViewAllMoviesIncategory"{
            let destinationViewAllVC = segue.destination as! ViewAllMoviesCollectionViewController
            destinationViewAllVC.category = selectedCategoryForViewAllMoviesInCategory
        }
        else{
            let destinationDetailVC = segue.destination as! MovieDetailTableViewController
            if let selectedMovie = selectedMovie{
                destinationDetailVC.selectedMovie = selectedMovie
            }
        }
    }
//MARK: - data loading part
    func loadMovieData(){
        //requesting data from API
        for category in AllCategories.categories{
            let parameters = URLS.getParametersForEnumCase(URLSEnumCase: .AllMoviesURL,withAdditionalValue: category.genreID)
            if let url = URLS.getURLFromEnumRawValue(URLSEnumCase: .AllMoviesURL){
                APIRequest.sharedAPIRequest.requestData(fromUrl:url,withParameters: parameters, forViewController: self,
                 noInternetConnectionHandler: {
                    self.loadMovieData()
                })
                { [weak self](allMoviesJSON) in
                    if let allMoviesJSON = allMoviesJSON{
                        let categoryWithMovies = self?.parseMovieJSON(json: allMoviesJSON, to: category)
                        if let categoryWithMovies = categoryWithMovies{
                            self?.queue.sync {
                                self?.categories.append(categoryWithMovies)
                            }
                            self?.categoryCollectionView.reloadDataInMainThread()
                            self?.categorySelectionTableView.reloadInMainThread()
                        }
                    }
                }
            } 
            
        }
        
    }
    
    
    private func parseMovieJSON(json:JSON,to category:MovieCategory)->MovieCategory{
        
        //parsing the data returned from api
        let categoryWithMovies = MovieCategory(genreID: category.genreID, categoryTitle: category.categoryTitle)
        JSONParser.sharedParser.parseJSON(fromJSON: json) { [weak self](json) in
                let result = json!["results"]
                for i in 0 ..< result.count{
                    // movie title
                    let title = result[i]["title"].stringValue
                    // movie poster path
                    let posterPath = result[i]["poster_path"].stringValue
                    // the complete movie poster url string
                    let posterURLString = URLS.getUrlStringForEnumRawValue(URLSEnumCase: .moviePosterURL,withAdditionalValue: posterPath)
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
                    if let movie = movie{
                        self?.addMovieToCategory(movie: movie, toCategory: categoryWithMovies)
                    }
                }
            }
        return categoryWithMovies
    }
    
}

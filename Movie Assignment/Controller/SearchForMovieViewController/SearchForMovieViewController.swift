//
//  SearchForMovieViewController.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/13/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
class SearchForMovieViewController: UIViewController {
    //MARK: - IBOUtlets part
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    //MARK: - properties part
    var searchResultMovie:Movie!
    var searchResutlMovies:[Movie] = []
    private let queue = DispatchQueue(label: "appending items to array")
    var tapGestureRecogniser:UITapGestureRecognizer!
    var selectedMovie:Movie?
    //MARK: - view methodes part
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultCollectionView.setDelegateAndDatasource(toObject: self)
        RegisterCollectionViewCell()
        setSearchResultCollectionViewCellSize()
        movieSearchBar.delegate = self
        tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        searchResultCollectionView.addGestureRecognizer(tapGestureRecogniser)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        movieSearchBar.becomeFirstResponder()
        tapGestureRecogniser.isEnabled = true
    }
    
    //MARK: - prepare for sugue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationDetailVC = segue.destination as!MovieDetailTableViewController
        destinationDetailVC.selectedMovie = selectedMovie
    }
    //MARK: - selector methodes part
    @objc func hideKeyboard(){
        movieSearchBar.endEditing(true)
       }
    //MARK: - helperMethodes part
    private func RegisterCollectionViewCell(){
        searchResultCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    private func setSearchResultCollectionViewCellSize(){
        let width = (view.frame.size.width-20)/3
        let height = view.frame.size.height/4
        searchResultCollectionView.setCollectionViewCellSize(width: width, height: height)
    }
    private func getMovie(title:String,posterURL:String,overview:String, dateProduced:String,rating:String,movieId:String)->Movie{
        let movie = Movie(movieTitle: title, posterUrl: posterURL, rating: rating, overview: overview, dateProduced: dateProduced, movieId: movieId)
        return movie
    }
    
    //MARK: - loadind data part
    func loadData(fromMovieName movieName:String){
        let parameters = URLS.getParametersForEnumCase(URLSEnumCase: .searchForMovieURL,withAdditionalValue: movieName)
        if let url = URLS.getURLFromEnumRawValue(URLSEnumCase: .searchForMovieURL){
            APIRequest.sharedAPIRequest.requestData(fromUrl: url, withParameters: parameters) {
                [weak self](searchResultJSON) in
                if let searchResultJSON = searchResultJSON{
                    self?.parseSearchResultJSON(fromJSON: searchResultJSON)
                }
            }
        }
    }
    private func parseSearchResultJSON(fromJSON json:JSON){
        JSONParser.sharedParser.parseJSON(fromJSON: json) { [weak self](searchResultJSON) in
            let result = json["results"]
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
                print(movie?.movieTitle)
                self?.queue.sync {
                    self?.searchResutlMovies.append(movie!)
                }
                self?.searchResultCollectionView.reloadDataInMainThread()
            }
        }

    }
}

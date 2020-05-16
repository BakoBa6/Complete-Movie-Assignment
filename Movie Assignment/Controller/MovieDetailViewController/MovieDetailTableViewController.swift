//
//  MovieDetailTableViewController.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/11/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import RxSwift
import RxCocoa
class MovieDetailTableViewController: UITableViewController {
    //MARK: - IBOutlets part
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    //MARK: - properties part
    var selectedMovie:Movie?
    var favoriteMovie:FavouriteMovie?
    var isFavoriteButtonOn = false
    let titleLabelTextFontConstant:CGFloat = 0.035
    let otherLabelTextFontContstant:CGFloat = 0.023
    let tableViewRowHeightConstant:CGFloat = 0.079
    //MARK: - view methodes part
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllRequiredCells()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        setBackgroundImageWithBlurEffect()
        checkForDublicates()
        configureFavoriteButtonForViewStarting()
        sendDataToDataStroringManager()
        
    }
    //MARK: - IBActions part
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        DataStoringManager.sharedStoringManager.storeOrRemoveFavoriteMovie()
        selectedMovie!.isFavorite.negate()
        setFavoriteButtonImage(dependingOn: selectedMovie!.isFavorite)
    }
    //MARK: - helper methodes
    
    private func configureFavoriteButtonForViewStarting(){
        if let favoriteMovie = favoriteMovie{
            if  favoriteMovie.isFavorite{
                setFavoriteButtonImage(dependingOn: true)
            }else{
                setFavoriteButtonImage(dependingOn: false)
            }
        }else{
            if let selectedMovie = selectedMovie{
                if selectedMovie.isFavorite {
                    setFavoriteButtonImage(dependingOn: true)
                }else{
                    setFavoriteButtonImage(dependingOn: false)
                }
            }
        }
    }
    private func sendDataToDataStroringManager(){
        DataStoringManager.sharedStoringManager.favoriteMovie = favoriteMovie
        DataStoringManager.sharedStoringManager.selectedMovie = selectedMovie
    }
    private func setFavoriteButtonImage(dependingOn bool:Bool){
        if bool{
            favoriteButton.image = UIImage(systemName: "star.fill")
        }else{
            favoriteButton.image = UIImage(systemName: "star")
        }
        
    }
    private func checkForDublicates(){
        if let favoriteMovies = AllFavoriteMovies.sharedFavoriteMovies.favoriteMovies,let selectedMovie = selectedMovie{
            for i in 0..<favoriteMovies.count{
                if selectedMovie.movieId == favoriteMovies[i].movieID{
                    selectedMovie.isFavorite = true
                    setFavoriteButtonImage(dependingOn: selectedMovie.isFavorite)
                    break
                }
            }
        }
    }
    private func setBackgroundImageWithBlurEffect(){
        let backGroundImageView = getBackGroundImageView()
        tableView.backgroundView = backGroundImageView
    }
    private func getBlurView()->UIVisualEffectView{
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tableView.frame
        return blurView
    }
    private func getBackGroundImageView()->UIImageView{
        let imageView = UIImageView()
        imageView.frame = tableView.frame
        if let selectedMovie = selectedMovie{
            if let url = selectedMovie.posterUrlString.convertToURL(){
                imageView.kf.setImage(with: url)
            }
            let blurView = getBlurView()
            imageView.addSubview(blurView)
        }
        return imageView
    }
    
    
    
    private func registerAllRequiredCells(){
        tableView.register(UINib(nibName: "MovieNormalCellWithLabel", bundle: nil), forCellReuseIdentifier: "normalCell")
        
        tableView.register(UINib(nibName: "MovieRatingAndTrailerButoonCell", bundle: nil), forCellReuseIdentifier: "ratingAndTrailerCell")
        
        tableView.register(UINib(nibName: "MoviePosterImageCell", bundle: nil), forCellReuseIdentifier: "posterCell")
    }
    //MARK: - prepare for segue part
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationTrailerVC = segue.destination as!WatchTrailerViewController
        if let selectedMovie = selectedMovie{
            destinationTrailerVC.movieID = selectedMovie.movieId
        }
    }
    //MARK: - Loading data
    private func loadData(){
        if let selectedMovie = selectedMovie{
            
            if let url = URLS.getURLFromEnumRawValue(URLSEnumCase: .movieDetailURL,withAdditionalValue: selectedMovie.movieId){
                APIRequest.sharedAPIRequest.requestData(fromUrl: url, withParameters: URLS.getParametersForEnumCase(URLSEnumCase: .movieDetailURL), forViewController: self,
                noInternetConnectionHandler: {
                self.loadData()
                })
                { [weak self](json) in
                    if let json = json{
                        self?.parseJSON(fromJSON: json)
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    private func parseJSON(fromJSON json:JSON){
        JSONParser.sharedParser.parseJSON(fromJSON: json) { [weak self](movieDetailJSON) in
            let firstActor = movieDetailJSON!["cast"][0]["name"]
            let secondActor = movieDetailJSON!["cast"][1]["name"]
            if let selectedMovie = self?.selectedMovie{
                selectedMovie.actors = "Actors: \(firstActor) and \(secondActor)"
                selectedMovie.director = movieDetailJSON!["crew"][5]["name"].stringValue
            }
        }
        
    }
}

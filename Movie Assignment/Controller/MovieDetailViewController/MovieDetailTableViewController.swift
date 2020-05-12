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
class MovieDetailTableViewController: UITableViewController {
    //MARK: - properties part
    var movieActors:String?
    var movieDirector:String?
    var selectedMovie:Movie?
    //MARK: - view methodes part
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllRequiredCells()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        setBackgroundImageWithBlurEffect()
    }
    //MARK: - helper methodes
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
            let posterURLString = selectedMovie.posterUrlString
            if let url = posterURLString.convertToURL(){
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
                APIRequest.sharedAPIRequest.requestData(fromUrl: url, withParameters: URLS.getParametersForEnumCase(URLSEnumCase: .movieDetailURL)) { [weak self](json) in
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
                self?.movieActors = "Actors: \(firstActor) and \(secondActor)"
                self?.movieDirector = movieDetailJSON!["crew"][5]["name"].stringValue
            }
            
    }
}

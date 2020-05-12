//
//  MovieDetails.swift
//  Movies Asignment
//
//  Created by bako abdullah on 2/3/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
class Movie{
   let movieTitle:String
      let posterUrlString:String
      let rating:String
      let overview:String
      let dateProduced:String
      let movieId:String
      var isFavourite = false
    init (movieTitle:String, posterUrl: String, rating: String, overview: String, dateProduced: String, movieId: String){
        self.movieTitle = movieTitle
        self.movieId = movieId
        self.dateProduced = dateProduced
        self.overview = overview
        self.posterUrlString = posterUrl
        self.rating = rating
    }
}

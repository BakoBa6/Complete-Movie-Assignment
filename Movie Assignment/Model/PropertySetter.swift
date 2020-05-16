//
//  FactoryClass.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/14/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import Foundation
class PropertySetter{
    static let SharedSetter = PropertySetter()
    private init(){}
    func setFavoriteMovieProperties(fromMovie movie:Movie)->FavouriteMovie{
         let favoriteMovie = FavouriteMovie()
         favoriteMovie.dateProduced = movie.dateProduced
         favoriteMovie.movieID = movie.movieId
         favoriteMovie.movieOverview = movie.overview
         favoriteMovie.movieRating = movie.rating
         favoriteMovie.movieTitle = movie.movieTitle
         favoriteMovie.posterUrlString = movie.posterUrlString
         favoriteMovie.director = movie.director
         favoriteMovie.movieActors = movie.actors
        return favoriteMovie
    }
    func setMovieProperties(from favoriteMovie:FavouriteMovie)->Movie{
        let dateProduced = favoriteMovie.dateProduced
        let overview = favoriteMovie.movieOverview
        let title = favoriteMovie.movieTitle
        let rating = favoriteMovie.movieRating
        let posterURLString = favoriteMovie.posterUrlString
        let movieID = favoriteMovie.movieID
        let movie = Movie(movieTitle: title, posterUrl: posterURLString, rating: rating, overview: overview, dateProduced: dateProduced, movieId: movieID)
        movie.actors = favoriteMovie.movieActors
        movie.director = favoriteMovie.director
        movie.isFavorite = favoriteMovie.isFavorite
        return movie
    }
}

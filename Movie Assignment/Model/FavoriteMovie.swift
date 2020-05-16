//
//  FavoriteMovie.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/14/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import Foundation
import RealmSwift
class FavouriteMovie:Object{
    @objc dynamic var movieTitle = ""
    @objc dynamic  var posterUrlString = ""
    @objc dynamic  var movieRating = ""
    @objc dynamic var movieOverview = ""
    @objc dynamic  var dateProduced = ""
    @objc dynamic  var movieID = ""
    @objc dynamic var movieActors = ""
    @objc dynamic var director = ""
    @objc dynamic  var isFavorite = false
}

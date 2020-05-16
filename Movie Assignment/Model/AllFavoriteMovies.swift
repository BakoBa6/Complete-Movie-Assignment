//
//  AllFavoriteMovies.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/14/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import Foundation
import RealmSwift
class AllFavoriteMovies{
    static let sharedFavoriteMovies = AllFavoriteMovies()
    private init(){}
var favoriteMovies:Results<FavouriteMovie>!
}

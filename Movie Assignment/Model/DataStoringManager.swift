//
//  DataStoringManager.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/14/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import Foundation
import RealmSwift
class DataStoringManager{
    var favoriteMovie:FavouriteMovie?
    var selectedMovie:Movie?
    let realm = RealmObject.realm
    static let sharedStoringManager = DataStoringManager()
    private init(){}
    func storeOrRemoveFavoriteMovie(){
        prepareFavoriteMovieInstanceIfNil()
        if favoriteMovie != nil{
            manageFavoriteMovieStorage()
        }
    }
    private func prepareFavoriteMovieInstanceIfNil(){
        if favoriteMovie == nil{
            prepareFavoriteMovieInstance()
        }
    }
    private func manageFavoriteMovieStorage(){
        if favoriteMovie!.isFavorite{
            removeDataFromRealm()
        }else{
            addDataToRealm()
        }
    }
    private func removeDataFromRealm(){
        let predicate = NSPredicate(format: "movieID CONTAINS %@", favoriteMovie!.movieID)
        do{
            
            try realm.write {
                self.favoriteMovie!.isFavorite.negate()
                realm.delete(realm.objects(FavouriteMovie.self).filter(predicate))
                self.favoriteMovie = nil
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    private func addDataToRealm(){
        do{
            try realm.write {
                realm.add(self.favoriteMovie!)
                self.favoriteMovie!.isFavorite.negate()
            }
            
        }catch{
            print(error.localizedDescription)
        }
    }
    private func prepareFavoriteMovieInstance(){
        if let selectedMovie = selectedMovie{
            self.favoriteMovie = PropertySetter.SharedSetter.setFavoriteMovieProperties(fromMovie: selectedMovie)
            if selectedMovie.isFavorite{
                favoriteMovie?.isFavorite = true
            }
        }
    }
}

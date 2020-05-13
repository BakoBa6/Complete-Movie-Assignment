//
//  SearchForMovieViewController+SearchBarDelegate Extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/13/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
extension SearchForMovieViewController:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tapGestureRecogniser.isEnabled = false
        searchBar.resignFirstResponder()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tapGestureRecogniser.isEnabled = false
        searchBar.showsCancelButton = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResutlMovies = []
        if let movieName = searchBar.text{
         loadData(fromMovieName: movieName)
        }
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
          tapGestureRecogniser.isEnabled = true
          searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
      }
}

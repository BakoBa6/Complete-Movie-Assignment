//
//  SearchForMovieViewController+SearchBarDelegate Extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/13/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
extension SearchForMovieViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        tapGestureRecogniser.isEnabled = false
        hideCancelButton()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tapGestureRecogniser.isEnabled = true
        textField.becomeFirstResponder()
        showCancelButton()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchResutlMovies = []
        if let movieName = textField.text{
            loadData(fromMovieName: movieName)
        }
        hideCancelButton()
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
    
}

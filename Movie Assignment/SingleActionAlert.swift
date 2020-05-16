//
//  NoInternetConnectionAlert.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/15/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
class SingleActionAlert{
    static let sharedAlert = SingleActionAlert()
    private init(){}
    func showNoSingleActionConnectionAlert(withTitle title:String,withMessage message:String,AlertButtonHandler:@escaping()->Void)->UIAlertController{
        let alert = UIAlertController(title:title , message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (alert) in
            AlertButtonHandler()
        }
        alert.addAction(action)
        return alert
    }
}

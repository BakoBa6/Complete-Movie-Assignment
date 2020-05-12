//
//  String+ToURL Extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/12/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import Foundation
extension String{
    func convertToURL()->URL?{
        let url = URL(string: self)
        if let url = url{
           return url
        }
        return nil
    }
}

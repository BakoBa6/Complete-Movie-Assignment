//
//  URLS.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/6/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import Foundation
enum URLS:String {
    case AllMoviesURL = "https://api.themoviedb.org/3/movie/popular"
    case moviePosterURL = "https://image.tmdb.org/t/p/w500/"
    case movieDetailURL = "https://api.themoviedb.org/3/movie/"
    case movieTrailerVideoiURL = "https://api.themoviedb.org/3/movie"
    case youtubeTrailerVideoURL = "https://www.youtube.com/watch?v="
    case searchForMovieURL = "https://api.themoviedb.org/3/search/movie?"
    //get the parameters for the url request of the chosen enum case
    static func getParametersForEnumCase(URLSEnumCase enumCase:URLS,withAdditionalValue additionalValue:String? = nil)->[String:String]{
        switch enumCase {
        case .AllMoviesURL:
            if let value = additionalValue{
                return ["api_key":"8460d476d21be7e26a99234d8ca8de51","sort_by":"false", "page" : "1","include_video":"false","primary_release_date.gte":"2019-01-01","with_genres": value]
            }
            else{
                return[:]
            }
            
        case .moviePosterURL:
            return [:]
        case .movieDetailURL:
            return ["api_key":"8460d476d21be7e26a99234d8ca8de51"]
        case .movieTrailerVideoiURL:
            return ["api_key":"8460d476d21be7e26a99234d8ca8de51","append_to_response":"videos"]
        case .youtubeTrailerVideoURL:
            return [:]
        case .searchForMovieURL:
            if let value = additionalValue{
                return ["api_key":"8460d476d21be7e26a99234d8ca8de51","query":value]
            }else{
            return [:]
        }
    }
    }
    // get the url of the chosen enum case
    static func getURLFromEnumRawValue(URLSEnumCase enumCase:URLS,withAdditionalValue additionalValue:String? = nil)->URL?{
        switch enumCase {
        case .AllMoviesURL:
            return URL(string: enumCase.rawValue )
        case .moviePosterURL:
            if let value = additionalValue{
                return URL(string: enumCase.rawValue+value)
            }else{
                return URL(string: enumCase.rawValue)
            }
        case .movieDetailURL:
            if let value = additionalValue{
                return URL(string:enumCase.rawValue+value+"credits?")
            }else{
                return URL(string:enumCase.rawValue )!
            }
        case .movieTrailerVideoiURL:
            if let value = additionalValue{
                return URL(string:enumCase.rawValue+"/"+value+"?")
            }else{
                return URL(string: enumCase.rawValue)!
            }
        case .youtubeTrailerVideoURL:
            if let value = additionalValue{
                return URL(string: enumCase.rawValue+value)
            }else{
                return URL(string: enumCase.rawValue)
            }
            
        case .searchForMovieURL:
            return URL(string: enumCase.rawValue)
        }
    }
    
    
    //return the string value of the chosen enum case url
    static func getUrlStringForEnumRawValue(URLSEnumCase enumCase:URLS,withAdditionalValue additionalValue:String? = nil)->String{
        switch enumCase {
        case .AllMoviesURL:
            return enumCase.rawValue
        case .moviePosterURL:
            if let additionalValue = additionalValue{
                return String(describing:enumCase.rawValue+additionalValue)
            }else{
                return enumCase.rawValue
            }
            
        case .movieDetailURL:
            return enumCase.rawValue
        case .movieTrailerVideoiURL:
            if let value = additionalValue{
                return enumCase.rawValue+value+"?"
            }else{
                return enumCase.rawValue
            }
        case .youtubeTrailerVideoURL:
            if let value = additionalValue{
                return enumCase.rawValue+value
            }else{
                return enumCase.rawValue
            }
        case .searchForMovieURL:
            return enumCase.rawValue
        }
    }
}

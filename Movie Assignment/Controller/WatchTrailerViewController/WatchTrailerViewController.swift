//
//  WatchTrailerViewController.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/12/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
import SwiftyJSON
import WebKit
class WatchTrailerViewController: UIViewController {
    //MARK: - properties part
    var movieID:String?
    private var videoKey:String?
    
    //MARK: - IBOutlets part
    @IBOutlet weak var WKWebView: WKWebView!
    //MARK: - view methodes part
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    //MARK: - helper methodes
    private func PrepareURLRequestAndLoad(forVideoKey videokey:String){
        if let url = URLS.getURLFromEnumRawValue(URLSEnumCase: .youtubeTrailerVideoURL,withAdditionalValue:videoKey){
            let request = URLRequest(url: url)
            loadTrailerVideo(fromURLrequest: request)
        }
        
    }
    private func loadTrailerVideo(fromURLrequest urlrequest:URLRequest){
        DispatchQueue.main.async {
            self.WKWebView.load(urlrequest)
        }
    }
    //MARK: - load data part
    private func loadData(){
        let parameters = URLS.getParametersForEnumCase(URLSEnumCase:.movieTrailerVideoiURL)
        if let movieID = movieID{
            if let url = URLS.getURLFromEnumRawValue(URLSEnumCase: .movieTrailerVideoiURL,withAdditionalValue: movieID){
                APIRequest.sharedAPIRequest.requestData(fromUrl: url, withParameters: parameters, forViewController: self,
                    noInternetConnectionHandler: {
                    self.loadData()
                })
                {[weak self] (movieTrailerJSON) in
                    if let movieTrailerJSON = movieTrailerJSON{
                        self?.parseMovieTrailerJSON(fromJSON: movieTrailerJSON)
                    }
                }
            }
        }
    }
    private func parseMovieTrailerJSON(fromJSON json:JSON){
        JSONParser.sharedParser.parseJSON(fromJSON: json) {[weak self] (movieTrailerJSON) in
            let videoKey = movieTrailerJSON!["videos"]["results"][0]["key"].stringValue
            self?.videoKey = videoKey
            if let videoKey = self?.videoKey{
                self?.PrepareURLRequestAndLoad(forVideoKey: videoKey)
            }
        }
    }
}



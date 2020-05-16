//
//  SearchForMovieViewController.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/13/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
class SearchForMovieViewController: UIViewController{
    //MARK: - IBOUtlets part
    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cancelButtonTraillingConsraint: NSLayoutConstraint!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var searchViewHeightConstraint: NSLayoutConstraint!
    //MARK: - properties part
    var searchResultMovie:Movie!
    var searchResutlMovies:[Movie] = []
    private let queue = DispatchQueue(label: "appending items to array")
    var tapGestureRecogniser:UITapGestureRecognizer!
    var selectedMovie:Movie?
    let cancelButtonFontConstant:CGFloat = 0.016
    let searchViewHeightConstant:CGFloat = 0.06
    var deviceHeight:CGFloat?
    //MARK: - view methodes part
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultCollectionView.setDelegateAndDatasource(toObject: self)
        RegisterCollectionViewCell()
        setSearchResultCollectionViewCellSize()
        tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        searchResultCollectionView.addGestureRecognizer(tapGestureRecogniser)
        searchTextField.delegate = self
        deviceHeight = view.frame.size.height
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cancelButtonTraillingConsraint.constant = 0
        searchTextField.becomeFirstResponder()
        tapGestureRecogniser.isEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSearchViewHeight()
        setCancelButtonFontSize()
        setSearchTextFieldCornerRadius()
    }
    
    //MARK: - prepare for sugue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationDetailVC = segue.destination as!MovieDetailTableViewController
        destinationDetailVC.selectedMovie = selectedMovie
    }
    //MARK: - selector methodes part
    @objc func hideKeyboard(){
        searchTextField.endEditing(true)
    }
    //MARK: - IBAction part
    
    @IBAction func searchTextFieldCancelButtonPressed(_ sender: UIButton) {
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
        tapGestureRecogniser.isEnabled = false
        hideCancelButton()
    }
    //MARK: - helperMethodes part
    private func setSearchTextFieldCornerRadius(){
        searchTextField.layer.cornerRadius = 15
    }
     func showCancelButton(){
        UIView.animate(withDuration: 0.6) {
            self.cancelButtonTraillingConsraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
     func hideCancelButton(){
        UIView.animate(withDuration: 0.6) {
            let cancelButtonWidth = self.CancelButton.frame.size.width
            self.cancelButtonTraillingConsraint.constant = cancelButtonWidth * -1
            self.view.layoutIfNeeded()
        }
    }
    private func setCancelButtonFontSize(){
        CancelButton.titleLabel?.font = CancelButton.titleLabel?.font.withSize(deviceHeight!*cancelButtonFontConstant)
    }
    private func setSearchViewHeight(){
        searchViewHeightConstraint.constant = deviceHeight!*searchViewHeightConstant
    }
    private func RegisterCollectionViewCell(){
        searchResultCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    private func setSearchResultCollectionViewCellSize(){
        let width = (view.frame.size.width-20)/3
        let height = view.frame.size.height/4
        searchResultCollectionView.setCollectionViewCellSize(width: width, height: height)
    }
    private func getMovie(title:String,posterURL:String,overview:String, dateProduced:String,rating:String,movieId:String)->Movie{
        let movie = Movie(movieTitle: title, posterUrl: posterURL, rating: rating, overview: overview, dateProduced: dateProduced, movieId: movieId)
        return movie
    }
    
    //MARK: - loadind data part
    func loadData(fromMovieName movieName:String){
        let parameters = URLS.getParametersForEnumCase(URLSEnumCase: .searchForMovieURL,withAdditionalValue: movieName)
        if let url = URLS.getURLFromEnumRawValue(URLSEnumCase: .searchForMovieURL){
            APIRequest.sharedAPIRequest.requestData(fromUrl: url, withParameters: parameters, forViewController: self,
                                                    noInternetConnectionHandler: {
                                                        self.loadData(fromMovieName: movieName)
            })
            {
                [weak self](searchResultJSON) in
                if let searchResultJSON = searchResultJSON{
                    self?.parseSearchResultJSON(fromJSON: searchResultJSON)
                }
            }
        }
    }
    private func parseSearchResultJSON(fromJSON json:JSON){
        JSONParser.sharedParser.parseJSON(fromJSON: json) { [weak self](searchResultJSON) in
            let result = json["results"]
            for i in 0 ..< result.count{
                // movie title
                let title = result[i]["title"].stringValue
                // movie poster path
                let posterPath = result[i]["poster_path"].stringValue
                // the complete movie poster url string
                let posterURLString = URLS.getUrlStringForEnumRawValue(URLSEnumCase: .moviePosterURL,withAdditionalValue: posterPath)
                // movie overview
                let overview = result[i]["overview"].stringValue
                // date when the movie was produced
                let dateProduced = result[i]["release_date"].stringValue
                //movie rating
                let rating = result[i]["vote_average"].stringValue
                //movie id
                let movieId = result[i]["id"].stringValue
                
                //creating a movie object with above information with the help of a helper method
                let movie = self?.getMovie(title: title, posterURL: posterURLString, overview: overview, dateProduced: dateProduced, rating: rating, movieId: movieId)
                self?.queue.sync {
                    self?.searchResutlMovies.append(movie!)
                }
                self?.searchResultCollectionView.reloadDataInMainThread()
            }
        }
        
    }
}

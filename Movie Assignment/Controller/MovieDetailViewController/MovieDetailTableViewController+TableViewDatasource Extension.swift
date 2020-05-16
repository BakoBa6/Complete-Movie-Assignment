//
//  MovieDetailTableViewController+TableViewDatasource Extension.swift
//  Movie Assignment
//
//  Created by bako abdullah on 5/11/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
// dataSource methodes 
extension MovieDetailTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let selectedMovie = selectedMovie{
            tableView.estimatedRowHeight = 60
            tableView.rowHeight = UITableView.automaticDimension
            let deviceHeight = view.frame.size.height
            if indexPath.row == 0{
                let imageCell = tableView.dequeueReusableCell(withIdentifier: "posterCell", for: indexPath) as! MoviePosterImageCell
                if let url = selectedMovie.posterUrlString.convertToURL(){
                    imageCell.posterImageView.kf.setImage(with: url)
                }
                tableView.rowHeight = deviceHeight/2
                imageCell.backgroundColor = .clear
                return imageCell
            }
                

                
            else if indexPath.row == 1{
                let titleCell =  tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath) as!MovieNormalCellWithLabel
                titleCell.normalCellLabel.text = "Title: \(String(describing: selectedMovie.movieTitle))"
                
                titleCell.normalCellLabel.font = titleCell.normalCellLabel.font.withSize((deviceHeight)*titleLabelTextFontConstant)
                
                titleCell.backgroundColor = .clear
                return titleCell
            }
                
           
            
            
            else if indexPath.row == 2{
                let dateCell =  tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath) as!MovieNormalCellWithLabel
                
                dateCell.normalCellLabel.font = dateCell.normalCellLabel.font.withSize((deviceHeight)*otherLabelTextFontContstant)
                
                dateCell.normalCellLabel.text = "Date: \(String(describing: selectedMovie.dateProduced))"
                tableView.rowHeight = 70
                dateCell.backgroundColor = .clear
                return dateCell
            }
                
            
            
            
            else if indexPath.row == 3{
                let actorsCell =  tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath) as!MovieNormalCellWithLabel
                
                actorsCell.normalCellLabel.font = actorsCell.normalCellLabel.font.withSize((deviceHeight)*otherLabelTextFontContstant)
                
                actorsCell.normalCellLabel.text = "Actors: \(String(describing: selectedMovie.actors))"
                actorsCell.backgroundColor = .clear
                tableView.rowHeight = deviceHeight*tableViewRowHeightConstant
                return actorsCell
            }
                
            
            
            else if indexPath.row == 4{
                let directorCell =  tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath) as!MovieNormalCellWithLabel
                
                directorCell.normalCellLabel.font = directorCell.normalCellLabel.font.withSize((deviceHeight)*otherLabelTextFontContstant)
                
                directorCell.normalCellLabel.text = "Director: \(String(describing: selectedMovie.director))"
                tableView.rowHeight = deviceHeight*tableViewRowHeightConstant
                directorCell.backgroundColor = .clear
                return directorCell
            }
                
           
            
            else if indexPath.row == 5{
                let overviewCell =  tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath) as!MovieNormalCellWithLabel
                
                overviewCell.normalCellLabel.font = overviewCell.normalCellLabel.font.withSize((deviceHeight)*otherLabelTextFontContstant)
                
                overviewCell.normalCellLabel.text = selectedMovie.overview
                overviewCell.backgroundColor = .clear
                return overviewCell
            }
                
           
            
            else{
                let ratingAndtrailerCell = tableView.dequeueReusableCell(withIdentifier: "ratingAndTrailerCell", for: indexPath) as!MovieRatingAndTrailerButoonCell
                ratingAndtrailerCell.ratingLabel.text = selectedMovie.rating
                tableView.rowHeight = deviceHeight*tableViewRowHeightConstant
                ratingAndtrailerCell.backgroundColor = .clear
                subscribeWatchTrailerButton(forCell: ratingAndtrailerCell)
                return ratingAndtrailerCell
            }
        }
            
            
        else{
            return UITableViewCell()
        }
        
}
    private func subscribeWatchTrailerButton(forCell cell:MovieRatingAndTrailerButoonCell){
        cell.whatchtrailerButton.rx.tap.subscribe(onNext: { [weak self](_) in
            self?.performSegue(withIdentifier: "detailToTrailer", sender: self)
        }).disposed(by: cell.disposeBag)
    }
}

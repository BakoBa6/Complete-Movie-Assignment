//
//  RatingAndTrailerTableViewCell.swift
//  Movies Asignment
//
//  Created by bako abdullah on 2/10/20.
//  Copyright © 2020 bako abdullah. All rights reserved.
//

import UIKit
import RxSwift
class MovieRatingAndTrailerButoonCell: UITableViewCell {
//MARK: - properties part
var disposeBag = DisposeBag()
//MARK: - IBOutlets part
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var whatchtrailerButton: UIButton!
    //MARK: - view methodes part
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

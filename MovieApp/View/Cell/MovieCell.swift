//
//  MovieCell.swift
//  MovieApp
//
//  Created by Riajur Rahman on 23/2/21.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with viewModel: MovieViewModel) {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        titleLabel.text = viewModel.title
        posterImageView.kf.indicatorType = .activity
        if let urlString = viewModel.poster, let url = URL(string: urlString) {
            posterImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ic_placeholder"),
                options: [
                    .transition(.fade(0.1)),
                    .cacheOriginalImage
                ]
            )
        } else {
            posterImageView.image = UIImage(named: "ic_placeholder")
        }
    }
}

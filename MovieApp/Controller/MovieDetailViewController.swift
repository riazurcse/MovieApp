//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Riajur Rahman on 24/2/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieDetailsViewModel: MovieDetailsViewModel?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var metascoreLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var awardLabel: UILabel!
    @IBOutlet weak var boxOfficeLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"
        
        posterImageView.kf.indicatorType = .activity
        if let urlString = movieDetailsViewModel?.poster, let url = URL(string: urlString) {
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
        
        titleLabel.text = movieDetailsViewModel?.title
        yearLabel.text = movieDetailsViewModel?.year
        genreLabel.text = movieDetailsViewModel?.genre
        runtimeLabel.text = String(format: "• %@", movieDetailsViewModel?.runtime ?? "N/A")
        plotLabel.text = movieDetailsViewModel?.plot
        rateLabel.text = String(format: "• %@", movieDetailsViewModel?.rated ?? "N/A")
        metascoreLabel.attributedText = buildAttributedString(normalString: "Score", boldString: movieDetailsViewModel?.metascore ?? "N/A")
        voteLabel.attributedText = buildAttributedString(normalString: "Vote", boldString: movieDetailsViewModel?.imdbVotes ?? "N/A")
        ratingLabel.attributedText = buildAttributedString(normalString: "IMDB Rating", boldString: "✭ \(movieDetailsViewModel?.imdbRating ?? "N/A")")
        
        actorsLabel.text = movieDetailsViewModel?.getActors()?.joined(separator: " •") ?? "N/A"
        directorLabel.text = movieDetailsViewModel?.getDirectors()?.joined(separator: " •") ?? "N/A"
        writerLabel.text = movieDetailsViewModel?.getWriters()?.joined(separator: " •") ?? "N/A"
        languageLabel.text = movieDetailsViewModel?.language ?? "N/A"
        releaseDateLabel.text = movieDetailsViewModel?.released ?? "N/A"
        countryLabel.text = movieDetailsViewModel?.country ?? "N/A"
        awardLabel.text = movieDetailsViewModel?.awards ?? "N/A"
        boxOfficeLabel.text = movieDetailsViewModel?.boxOffice ?? "N/A"
        productionLabel.text = movieDetailsViewModel?.production ?? "N/A"
    }
    
    
    func buildAttributedString(normalString: String, boldString: String) -> NSAttributedString {
        let boldAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.black]
        let normalAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        
        let finalString = NSMutableAttributedString(string: normalString, attributes: normalAttribute)
        finalString.append(NSAttributedString(string: "\n"))
        finalString.append(NSAttributedString(string: boldString, attributes: boldAttribute))
        return finalString
    }
}

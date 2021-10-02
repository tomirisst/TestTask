//
//  MovieCell.swift
//  TrendingMoviesApp
//
//  Created by Tomiris on 23.04.2021.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    public static let identifier = "MovieCell"

    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingContainerView: UIView!
    
    @IBOutlet weak var descriptionText: UILabel!
    
    public var delegate: FavoriteMoviesDelegate?
    
    var indexPath: IndexPath = []
    
    public var movie: MovieEntity.Movie? {
        didSet{
            if let movie = movie{
                let posterURL = URL(string:  movie.poster ?? "")
                posterImageView.kf.setImage(with: posterURL)
                ratingLabel.text = " "
                movieTitleLabel.text = movie.title
                movieTitleLabel.numberOfLines = 0
                movieTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

                authorLabel.text = movie.author
                descriptionText.text = movie.description
                descriptionText.numberOfLines = 0
                descriptionText.setContentCompressionResistancePriority(.required, for: .vertical)
                
                if let _ = CoreDataManager.shared.findMovie(with: movie.title) {
                        favouriteButton.setImage(UIImage(named: "filledStar"), for: .normal)
                    } else {
                        favouriteButton.setImage(UIImage(named: "unfilledStar"), for: .normal)
                    }
                
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        ratingContainerView.layer.cornerRadius = 20
        ratingContainerView.layer.masksToBounds = true
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.masksToBounds = true
        
    }

    @IBAction func favouriteButtonPressed(_ sender: Any) {
        if let movie = movie {
            if let _ = CoreDataManager.shared.findMovie(with: movie.title) {
                CoreDataManager.shared.deleteMovie(with: movie.title)
                favouriteButton.setImage(UIImage(named: "unfilledStar"), for: .normal)
            } else {
                CoreDataManager.shared.addMovie(movie)
                favouriteButton.setImage(UIImage(named: "filledStar"), for: .normal)
            }
            delegate?.updateMovies()
        }
            
            
    }
}
    
    


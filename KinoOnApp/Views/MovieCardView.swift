import Foundation
import UIKit

class MovieCardView: UICollectionViewCell {

    private var id = Int()
    private let movieImageView = UIImageView()
    private let ageLimitLabel = UILabel()
    private let movieNameLabel = UILabel()
    private var tapRecognizer: UIGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupMovieImage()
        setupAgeLimit()
        setupMovieName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillCell(model: MovieCard) {
        id = model.id
        movieImageView.image = model.image
        ageLimitLabel.text = "\(model.ageLimit)+"
        movieNameLabel.text = model.name
    }
    
    func setupMovieImage() {
        movieImageView.layer.cornerRadius = 16
        movieImageView.clipsToBounds = true
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(movieImageView)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: self.topAnchor),
            movieImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -28)
        ])
    }
    
    func setupAgeLimit() {
        ageLimitLabel.font = UIFont(name: "Roboto-Regular", size: 11)
        ageLimitLabel.textColor = .white
        ageLimitLabel.textAlignment = NSTextAlignment.center
        
        ageLimitLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        ageLimitLabel.layer.cornerRadius = 4
        ageLimitLabel.clipsToBounds = true
        
        ageLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ageLimitLabel)
        
        NSLayoutConstraint.activate([
            ageLimitLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            ageLimitLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            ageLimitLabel.widthAnchor.constraint(equalToConstant: 29),
            ageLimitLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setupMovieName() {
        movieNameLabel.font = UIFont(name: "OpenSans-Regular", size: 12)
        movieNameLabel.adjustsFontSizeToFitWidth = false
        movieNameLabel.lineBreakMode = .byTruncatingTail
        
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(movieNameLabel)
        
        NSLayoutConstraint.activate([
            movieNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            movieNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            movieNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }

    func getId() -> Int {
        return self.id
    }
}

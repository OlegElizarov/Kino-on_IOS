import Foundation
import UIKit

class ReviewView: UIView {
    private struct ReviewViewConstants {
        static let fontSize = CGFloat(20)
        static let smallFontSize = CGFloat(16)
        static let widthMultiplier = CGFloat(0.7)
        static let ratingWidth = CGFloat(50)
        static let radius = CGFloat(8)
        static let indent = CGFloat(10)
    }

    private var username = UILabel()
    private var rating = UILabel()
    private var comment = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setUp(rev: Review) {
        self.backgroundColor = .systemGray6
        setUpUsername(text: rev.user.username)
        setUpRating(value: rev.rating)
        setUpComment(text: rev.body)
    }

    private func setUpUsername(text: String) {
        self.addSubview(username)

        username.text = "@\(text)"
        username.font = UIFont.systemFont(ofSize: ReviewViewConstants.fontSize)
        username.textColor = UIColor.black
        username.adjustsFontSizeToFitWidth = true
        username.translatesAutoresizingMaskIntoConstraints = false

        username.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                constant: ReviewViewConstants.indent).isActive = true
        username.trailingAnchor.constraint(equalTo: self.leadingAnchor,
                constant: self.frame.width * ReviewViewConstants.widthMultiplier).isActive = true
        username.topAnchor.constraint(equalTo: self.topAnchor,
                constant: ReviewViewConstants.indent).isActive = true
        username.sizeToFit()

        username.layoutIfNeeded()
    }

    private func setUpRating(value: Int) {
        self.addSubview(rating)

        if value >= 7 {
            rating.backgroundColor = .green
        } else if value >= 4 {
            rating.backgroundColor = .yellow
        } else if value > 0 {
            rating.backgroundColor = .red
        } else {
            rating.backgroundColor = .white
        }

        rating.text = String(value)
        rating.font = UIFont.systemFont(ofSize: ReviewViewConstants.fontSize)
        rating.textColor = .black
        rating.layer.cornerRadius = ReviewViewConstants.radius
        rating.clipsToBounds = true
        rating.textAlignment = .center
        rating.adjustsFontSizeToFitWidth = true
        rating.translatesAutoresizingMaskIntoConstraints = false

        rating.leadingAnchor.constraint(equalTo: self.trailingAnchor,
                constant: -ReviewViewConstants.ratingWidth).isActive = true
        rating.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                constant: -ReviewViewConstants.indent).isActive = true
        rating.topAnchor.constraint(equalTo: self.topAnchor,
                constant: ReviewViewConstants.indent).isActive = true
        rating.bottomAnchor.constraint(equalTo: username.bottomAnchor).isActive = true

        rating.layoutIfNeeded()
    }

    private func setUpComment(text: String) {
        self.addSubview(comment)

        comment.text = text
        comment.font = UIFont.systemFont(ofSize: ReviewViewConstants.smallFontSize)
        comment.textColor = UIColor.black
        comment.adjustsFontSizeToFitWidth = true
        comment.translatesAutoresizingMaskIntoConstraints = false
        comment.numberOfLines = 0
//        comment.lineBreakMode = NSLineBreakMode.byWordWrapping

        comment.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                constant: ReviewViewConstants.indent).isActive = true
        comment.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                constant: -ReviewViewConstants.indent).isActive = true
        comment.topAnchor.constraint(equalTo: username.bottomAnchor,
                constant: ReviewViewConstants.indent).isActive = true
        comment.sizeToFit()

        comment.layoutIfNeeded()
        self.bottomAnchor.constraint(equalTo: comment.bottomAnchor,
                constant: ReviewViewConstants.indent).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
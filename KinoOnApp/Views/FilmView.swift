import Foundation
import UIKit

class FilmView: UIView {
    struct FilmViewConstants {
        static let titleHeightMultiplier = CGFloat(0.1)
        static let descHeightMultiplier = CGFloat(0.3)

        static let filmTitleTopAnchorIndent = CGFloat(10)
        static let indent = CGFloat(10)

        static let descFontSize = CGFloat(16)
        static let titleFontSize = CGFloat(24)
        static let descLines = 0
    }

    private var filmTitle = UILabel()
    private var filmDescription = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setUp(film: Film) {
        self.layoutIfNeeded()

        setUpTitle(title: film.title)
        setUpDesc(desc: film.description)
    }

    private func setUpTitle(title: String) {
        self.addSubview(filmTitle)

        filmTitle.text = title
        filmTitle.font = UIFont(name: "Roboto-Regular", size: FilmViewConstants.titleFontSize)
        filmTitle.textColor = UIColor.black
        filmTitle.adjustsFontSizeToFitWidth = true
        filmTitle.translatesAutoresizingMaskIntoConstraints = false

        filmTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                constant: FilmViewConstants.indent).isActive = true
        filmTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                constant: -FilmViewConstants.indent).isActive = true
        filmTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        filmTitle.bottomAnchor.constraint(equalTo: self.filmTitle.topAnchor,
                constant: FilmViewConstants.titleFontSize).isActive = true
        filmTitle.layoutIfNeeded()
    }

    private func setUpDesc(desc: String) {
        self.addSubview(filmDescription)

        filmDescription.text = desc
        filmDescription.font = UIFont(name: "Roboto-Regular", size: FilmViewConstants.descFontSize)
        filmDescription.textColor = UIColor.black
        filmDescription.adjustsFontSizeToFitWidth = false
        filmDescription.translatesAutoresizingMaskIntoConstraints = false
        filmDescription.numberOfLines = FilmViewConstants.descLines
        filmDescription.lineBreakMode = NSLineBreakMode.byWordWrapping

        filmDescription.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: FilmViewConstants.indent).isActive = true
        filmDescription.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -FilmViewConstants.indent).isActive = true
        filmDescription.topAnchor.constraint(
                equalTo: self.filmTitle.bottomAnchor, constant: FilmViewConstants.indent).isActive = true
        filmDescription.sizeToFit()
        filmDescription.layoutIfNeeded()

        self.bottomAnchor.constraint(equalTo: filmDescription.bottomAnchor).isActive = true
        self.layoutIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

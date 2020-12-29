import Foundation
import UIKit

class BannerItemView: UICollectionViewCell {
    private struct BannerItemViewConstants {
        static let indent = CGFloat(10)
        static let descFontSize = CGFloat(12)
        static let titleFontSize = CGFloat(24)
        static let descLines = 0
        static let descBottomIndent = CGFloat(20)
        static let descHeightMultiplier = CGFloat(0.2)
        static let titleHeightMultiplier = CGFloat(0.1)
    }

    private var filmTitle = UILabel()
    private var filmDescription = UILabel()
    lazy private var backgroundImage: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    lazy var info: FilmBannerInfo = {
        return FilmBannerInfo(id: 0, title: "", description: "", img: "")
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setUp(info: FilmBannerInfo) {
        self.info = info
        self.layoutIfNeeded()

        setUpBackgroundImage()
        setUpFilmTitle()
        setUpFilmDesc()
    }

    func setUpBackgroundImage() {
        self.addSubview(backgroundImage)

        backgroundImage.image = UIImage(named: info.img)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill

        backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true

        backgroundImage.layoutIfNeeded()
    }

    func setUpFilmTitle() {
        self.addSubview(filmTitle)

        filmTitle.text = info.title
        filmTitle.font = UIFont(name: "Roboto-Regular", size: BannerItemViewConstants.titleFontSize)
        filmTitle.textColor = .white
        filmTitle.adjustsFontSizeToFitWidth = false
        filmTitle.translatesAutoresizingMaskIntoConstraints = false

        filmTitle.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: BannerItemViewConstants.indent).isActive = true
        filmTitle.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -BannerItemViewConstants.indent).isActive = true
        filmTitle.topAnchor.constraint(equalTo: backgroundImage.topAnchor,
                constant: self.frame.height * 0.6).isActive = true

        filmTitle.sizeToFit()
        filmTitle.layoutIfNeeded()
    }

    func setUpFilmDesc() {
        self.addSubview(filmDescription)

        filmDescription.text = info.description
        filmDescription.font = UIFont(name: "Roboto-Regular", size: BannerItemViewConstants.descFontSize)
        filmDescription.textColor = UIColor.white
        filmDescription.adjustsFontSizeToFitWidth = false
        filmDescription.translatesAutoresizingMaskIntoConstraints = false
        filmDescription.numberOfLines = BannerItemViewConstants.descLines
        filmDescription.lineBreakMode = NSLineBreakMode.byWordWrapping

        filmDescription.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: BannerItemViewConstants.indent).isActive = true
        filmDescription.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -BannerItemViewConstants.indent).isActive = true
        filmDescription.topAnchor.constraint(
                equalTo: filmTitle.bottomAnchor).isActive = true

        filmDescription.sizeToFit()
        filmDescription.layoutIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

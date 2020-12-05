import Foundation
import UIKit

class BannerItemView: UICollectionViewCell {
    private struct BannerItemViewConstants {
        static let sideIndent = CGFloat(10)
        static let descFontSize = CGFloat(12)
        static let titleFontSize = CGFloat(24)
        static let descLines = 4
        static let descBottomIndent = CGFloat(20)
        static let descHeightMultiplier = CGFloat(0.2)
        static let titleHeightMutliplier = CGFloat(0.1)
    }
    
    private var filmTitle = UILabel()
    private var filmDescription =  UILabel()
    lazy private var backgroundImage: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    lazy private var info: FilmBannerInfo = {
        return FilmBannerInfo(title: "", description: "", img: "")
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setUp(info: FilmBannerInfo) {
        self.info = info
        self.layoutIfNeeded()
        
        setUpBackgroundImage()
        setUpFilmDesc()
        setUpFilmTitle()
    }
    
    func setUpBackgroundImage() {
        self.addSubview(backgroundImage)
        
        backgroundImage.image = UIImage(named: info.img)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        
        backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        backgroundImage.layoutIfNeeded()
    }
    
    func setUpFilmDesc() {
        self.addSubview(filmDescription)
        
        filmDescription.text = info.description
        filmDescription.font = UIFont.systemFont(ofSize: BannerItemViewConstants.descFontSize)
        filmDescription.textColor = UIColor.white
        filmDescription.adjustsFontSizeToFitWidth = false
        filmDescription.translatesAutoresizingMaskIntoConstraints = false
        filmDescription.numberOfLines = BannerItemViewConstants.descLines
        filmDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        filmDescription.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: BannerItemViewConstants.sideIndent).isActive = true
        filmDescription.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: BannerItemViewConstants.sideIndent).isActive = true
        filmDescription.bottomAnchor.constraint(
            equalTo: self.bottomAnchor,
            constant: -BannerItemViewConstants.descBottomIndent).isActive = true
        filmDescription.heightAnchor.constraint(
            equalTo: self.heightAnchor,
            multiplier: BannerItemViewConstants.descHeightMultiplier).isActive = true
        
        filmDescription.layoutIfNeeded()
    }
    
    func setUpFilmTitle() {
        self.addSubview(filmTitle)
        
        filmTitle.text = info.title
        filmTitle.font = UIFont.systemFont(ofSize: BannerItemViewConstants.titleFontSize)
        filmTitle.textColor = UIColor.white
        filmTitle.adjustsFontSizeToFitWidth = false
        filmTitle.translatesAutoresizingMaskIntoConstraints = false
        
        filmTitle.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: BannerItemViewConstants.sideIndent).isActive = true
        filmTitle.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: BannerItemViewConstants.sideIndent).isActive = true
        filmTitle.bottomAnchor.constraint(
            equalTo: self.filmDescription.topAnchor).isActive = true
        filmTitle.heightAnchor.constraint(
            equalTo: self.heightAnchor,
            multiplier: BannerItemViewConstants.titleHeightMutliplier).isActive = true
        
        filmTitle.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

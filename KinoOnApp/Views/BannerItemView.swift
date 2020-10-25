import Foundation
import UIKit

class BannerItemView: UIView {
    let leftIndent = CGFloat(15)
    let bottomIndent = CGFloat(-50)
    lazy private var backgroundImage: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    lazy private var filmTitle: UILabel = {
        return UILabel()
    }()
    lazy private var filmDescription: UILabel = {
        return UILabel()
    }()
    
    //test
    private var info: FilmBannerInfo!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        info = FilmBannerInfo(title: "Острые козырьки", description: "Криминальная сага в стиле ретро о банде и ее лютом боссе. Так популярна, что повысила продажи головных уборов.", img: "test_banner_img")
    }
    
    func setUp() {
        setUpBackgroundImage()
        setUpFilmTitle()
        setUpFilmDesc()
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
    }
    
    func setUpFilmTitle() {
        self.addSubview(filmTitle)
        
        filmTitle.text = info.title
        filmTitle.font = UIFont.systemFont(ofSize: 24)
        filmTitle.textColor = UIColor.white
        filmTitle.adjustsFontSizeToFitWidth = false
        filmTitle.translatesAutoresizingMaskIntoConstraints = false
        
        filmTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftIndent).isActive = true
        filmTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        filmTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomIndent * 3).isActive = true
        filmTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    func setUpFilmDesc() {
        self.addSubview(filmDescription)
        
        filmDescription.text = info.description
        filmDescription.font = UIFont.systemFont(ofSize: 12)
        filmDescription.textColor = UIColor.white
        filmDescription.adjustsFontSizeToFitWidth = false
        filmDescription.translatesAutoresizingMaskIntoConstraints = false
        filmDescription.numberOfLines = 4
        filmDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        filmDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftIndent * 1.2).isActive = true
        filmDescription.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        filmDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomIndent * 2).isActive = true
        filmDescription.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

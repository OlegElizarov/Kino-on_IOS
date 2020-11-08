import UIKit

class MovieCollectionHeader: UICollectionReusableView {
    
    private let collectionNameLabel = UILabel()
    private let showMoreLabel = UILabel()
    
    
    func setup(name: String) {
        setupCollectionName(name: name)
        setupShowMoreButton()
    }
    
    func setupCollectionName(name: String) {
        collectionNameLabel.text = name
        collectionNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        collectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionNameLabel)
        
        NSLayoutConstraint.activate([
            collectionNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            collectionNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
    
    func setupShowMoreButton() {
        showMoreLabel.text = "ЕЩЕ"
        showMoreLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        showMoreLabel.textColor = UIColor(red: 15/255, green: 76/255, blue: 129/255, alpha: 1)
        
        showMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(showMoreLabel)
        
        NSLayoutConstraint.activate([
            showMoreLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            showMoreLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -17)
        ])
    }
}

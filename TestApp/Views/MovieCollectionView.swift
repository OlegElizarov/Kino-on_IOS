import Foundation
import UIKit

class MovieCollectionView: UICollectionViewCell {
    
    private let collectionNameLabel = UILabel()
    private let showMoreLabel = UILabel()
    private var collection: MovieCollection!
    
    lazy private var moviesCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(MovieCardView.self, forCellWithReuseIdentifier: "MovieCard")
        
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    init(data: MovieCollection) {
        super.init(frame: .zero)
        collection = data
        setupHeader()
        setupMovieCollection()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeader() {
        collectionNameLabel.text = self.collection.name
        collectionNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        collectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionNameLabel)
        
        NSLayoutConstraint.activate([
            collectionNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            collectionNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)
        ])
        
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
    
    func setupMovieCollection() {
        addSubview(moviesCollectionView)
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 42),
            moviesCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            moviesCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            moviesCollectionView.heightAnchor.constraint(equalToConstant: 255)
        ])
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 162, height: 255)
        moviesCollectionView.setCollectionViewLayout(layout, animated: false)
    }
}

extension MovieCollectionView: UICollectionViewDelegate {
    
}

extension MovieCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collection.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCard", for: indexPath) as? MovieCardView else {
            return UICollectionViewCell()
        }
        
        cell.fillCell(model: self.collection.movies[indexPath.item])
        return cell
    }
}

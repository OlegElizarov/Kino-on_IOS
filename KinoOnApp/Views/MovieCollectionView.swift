import Foundation
import UIKit

class MovieCollectionView: UICollectionViewCell {
    
    private let collectionNameLabel = UILabel()
    private let showMoreLabel = UILabel()
    private var collection: MovieCollection!
    private var tapRecognizer: UIGestureRecognizer!

    lazy private var moviesCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(MovieCardView.self, forCellWithReuseIdentifier: "MovieCard")
        
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupHeader()
        setupMovieCollection()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(data: MovieCollection, action: UIGestureRecognizer) {
        collection = data
        tapRecognizer = action

        moviesCollectionView.isUserInteractionEnabled = true
        moviesCollectionView.addGestureRecognizer(tapRecognizer)

        collectionNameLabel.text = collection.name
    }
    
    func setupHeader() {
        collectionNameLabel.font = UIFont(name: "Montserrat-Bold", size: 24)
        
        collectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionNameLabel)
        
        NSLayoutConstraint.activate([
            collectionNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            collectionNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)
        ])
    }
    
    func setupMovieCollection() {
        self.addSubview(moviesCollectionView)
        
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

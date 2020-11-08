import Foundation
import UIKit

class ViewController: UIViewController {
    
    private var movieCollectionsData: [MovieCollection] = [
        MovieCollection(
            name: "Новое",
            movies: [
                MovieCard(id: 1, name: "Телохранитель киллера", ageLimit: 18, image: "1.png"),
                MovieCard(id: 2, name: "Джокер", ageLimit: 18, image: "2.png"),
                MovieCard(id: 3, name: "Ford против Ferrari", ageLimit: 16, image: "3.png"),
                MovieCard(id: 4, name: "Зеленая книга", ageLimit: 16, image: "4.png"),
                MovieCard(id: 5, name: "Бумажный дом", ageLimit: 18, image: "5.png")
            ]
        ),
        MovieCollection(
            name: "Комедии",
            movies: [
                MovieCard(id: 1, name: "Телохранитель киллера", ageLimit: 18, image: "1.png"),
                MovieCard(id: 2, name: "Джокер", ageLimit: 18, image: "2.png"),
                MovieCard(id: 3, name: "Ford против Ferrari", ageLimit: 16, image: "3.png"),
                MovieCard(id: 4, name: "Зеленая книга", ageLimit: 16, image: "4.png"),
                MovieCard(id: 5, name: "Бумажный дом", ageLimit: 18, image: "5.png")
            ]
        )
    ]
    
    lazy private var movieCollectionsView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(MovieCollectionView.self, forCellWithReuseIdentifier: "MovieCollection")
        
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupMovieCollections()
    }
    
    func setupMovieCollections() {
        view.addSubview(movieCollectionsView)
        
        NSLayoutConstraint.activate([
            movieCollectionsView.topAnchor.constraint(equalTo: view.topAnchor),
            movieCollectionsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            movieCollectionsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            movieCollectionsView.heightAnchor.constraint(equalToConstant: view.bounds.height)
        ])
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.bounds.width, height: 297)
        movieCollectionsView.setCollectionViewLayout(layout, animated: false)
    }
 }

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieCollectionsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollection", for: indexPath) as? MovieCollectionView else {
            return UICollectionViewCell()
        }
        
        cell.fillCell(model: self.movieCollectionsData[indexPath.item])
        return cell
    }
}

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
    
    private let scrollView = UIScrollView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setupMovieCollections()
    }
    
    func setupMovieCollections() {
        var leadingAnchor = scrollView.topAnchor
        
        for i in 0..<self.movieCollectionsData.count {
            let movieCollection = MovieCollectionView(data: self.movieCollectionsData[i])
            
            scrollView.addSubview(movieCollection)
            movieCollection.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                movieCollection.topAnchor.constraint(equalTo: leadingAnchor, constant: 30),
                movieCollection.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
                movieCollection.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
                movieCollection.heightAnchor.constraint(equalToConstant: 297)
            ])
            
            leadingAnchor = movieCollection.bottomAnchor
            
            if i == self.movieCollectionsData.count - 1 {
                movieCollection.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            }
        }
    }
 }

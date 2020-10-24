//
//  Collection.swift
//  TestApp
//
//  Created by User on 24.10.2020.
//

struct Movie {
    let id: Int
    let name: String
    let ageLimit: Int
    let Image: String
}

import UIKit

class CollectionViewController: UIViewController {
    var movies: [Movie] = []
    var collectionNameLabel: UILabel!
    var collectionScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ids = [1, 2, 3, 4, 5]
        let names = ["Телохранитель киллера", "Джокер", "Ford против Ferrari", "Зеленая книга", "Бумажный дом"]
        let ageLimits = [18, 18, 16, 16, 18]
        let images = ["1.png", "2.png", "3.png", "4.png", "5.png"]
        
        for i in 0..<5 {
            movies.append(Movie(id: ids[i], name: names[i], ageLimit: ageLimits[i], Image: images[i]))
        }
        
        view.backgroundColor = .white
        
        collectionNameLabel = UILabel()
        collectionNameLabel.text = "Новое"
        collectionNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        collectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionNameLabel)
        
        collectionScrollView = UIScrollView()
        collectionScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionScrollView)
        
        constraintsInit()
        
        var leadingAnchor = collectionScrollView.leftAnchor
        
        for movie in movies {
            let movieCardView = UIView()
            
            let movieImage = UIImage(named: movie.Image)
            let movieImageView = UIImageView(image: movieImage)
            movieImageView.contentMode = UIView.ContentMode.scaleAspectFit
            movieImageView.frame.size.width = 162
            movieImageView.frame.size.height = 226
            movieImageView.layer.cornerRadius = 16
            movieImageView.clipsToBounds = true
            movieImageView.translatesAutoresizingMaskIntoConstraints = false
            movieCardView.addSubview(movieImageView)
            
            let movieNameLabel = UILabel()
            movieNameLabel.text = movie.name
            movieNameLabel.font = UIFont.systemFont(ofSize: 12)
            movieNameLabel.adjustsFontSizeToFitWidth = false
            movieNameLabel.lineBreakMode = .byTruncatingTail
            movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
            movieCardView.addSubview(movieNameLabel)
            
            NSLayoutConstraint.activate([
                movieImageView.topAnchor.constraint(equalTo: movieCardView.topAnchor),
                movieImageView.centerYAnchor.constraint(equalTo: movieCardView.centerYAnchor),
                movieNameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 8),
                movieNameLabel.leftAnchor.constraint(equalTo: movieCardView.leftAnchor),
                movieNameLabel.widthAnchor.constraint(equalTo: movieCardView.widthAnchor, multiplier: 1)
            ])
            
            movieCardView.translatesAutoresizingMaskIntoConstraints = false
            collectionScrollView.addSubview(movieCardView)
            
            NSLayoutConstraint.activate([
                movieCardView.topAnchor.constraint(equalTo: collectionScrollView.topAnchor),
                movieCardView.leftAnchor.constraint(equalTo: leadingAnchor, constant: 11),
                movieCardView.widthAnchor.constraint(equalToConstant: 162)
            ])
            
            leadingAnchor = movieCardView.rightAnchor
        }
        
        collectionScrollView.rightAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }
    
    func constraintsInit() {
        let scrollViewHeightConstraint = NSLayoutConstraint.init(item: collectionScrollView, attribute: .height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 255.0)
        
        NSLayoutConstraint.activate(
            [collectionNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
             collectionNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
             collectionScrollView.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 13),
             collectionScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
             collectionScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
             scrollViewHeightConstraint
            ])
    }
}

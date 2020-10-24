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
    var showMoreLabel: UILabel!
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
        
        showMoreLabel = UILabel()
        showMoreLabel.text = "ЕЩЕ"
        showMoreLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        showMoreLabel.textColor = UIColor(red: 15/255, green: 76/255, blue: 129/255, alpha: 1)
        showMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(showMoreLabel)
        
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
            
            let ageLimitLabel = UILabel()
            ageLimitLabel.text = "\(movie.ageLimit)+"
            ageLimitLabel.font = UIFont.systemFont(ofSize: 11)
            ageLimitLabel.textColor = .white
            ageLimitLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            ageLimitLabel.textAlignment = NSTextAlignment.center
            ageLimitLabel.layer.cornerRadius = 4
            ageLimitLabel.clipsToBounds = true
            ageLimitLabel.translatesAutoresizingMaskIntoConstraints = false
            movieCardView.addSubview(ageLimitLabel)
            
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
                ageLimitLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -8),
                ageLimitLabel.rightAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: -8),
                ageLimitLabel.widthAnchor.constraint(equalToConstant: 29),
                ageLimitLabel.heightAnchor.constraint(equalToConstant: 16),
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
            [collectionNameLabel.topAnchor.constraint(equalTo: view.topAnchor),
             collectionNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
             showMoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 7),
             showMoreLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17),
             collectionScrollView.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 13),
             collectionScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
             collectionScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
             scrollViewHeightConstraint
            ])
    }
}

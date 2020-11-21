import Foundation
import UIKit

class HomeViewController: UIViewController {
    //test
    private var items = [FilmBannerInfo(
                            title: "Острые козырьки",
                            description:
                                "Криминальная сага в стиле ретро о банде и ее лютом боссе. Так популярна, что повысила продажи головных уборов.",
                            img: "test_banner_img"),
                         FilmBannerInfo(
                            title: "Джокер",
                            description:
                                "Готэм, начало 1980-х годов. Комик Артур Флек живет с больной матерью, которая с детства учит его «ходить с улыбкой».",
                            img: "test_banner_img_2")]
    
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
    
    lazy private var bannerView: UICollectionView = {
        let collView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collView.alwaysBounceHorizontal = true
        collView.translatesAutoresizingMaskIntoConstraints = false
        collView.delegate = self
        collView.dataSource = self
        collView.isPagingEnabled = true
        collView.register(BannerItemView.self, forCellWithReuseIdentifier: "BannerItemView")
        
        return collView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setUpBannerView()
        setupMovieCollections()
    }
    
    func setUpBannerView() {
        scrollView.addSubview(bannerView)
 
//        TODO
//        let navController = self.navigationController
//        let topInset = (navController?.view.safeAreaInsets.top ?? 0)
//            + (navController?.navigationBar.frame.height ?? 0)
//        let topInset = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let topInset = UIApplication.shared.statusBarFrame.height
        
        bannerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bannerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        bannerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: topInset).isActive = true
        bannerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        bannerView.layoutIfNeeded()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = bannerView.bounds.size
        
        bannerView.setCollectionViewLayout(layout, animated: false)
    }
    
    func setupMovieCollections() {
        var leadingAnchor = bannerView.bottomAnchor
        
        for i in 0..<self.movieCollectionsData.count {
            let movieCollection = MovieCollectionView(frame: .zero)
            movieCollection.fill(data: self.movieCollectionsData[i])
            
            scrollView.addSubview(movieCollection)
            movieCollection.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                movieCollection.topAnchor.constraint(equalTo: leadingAnchor, constant: 30),
                movieCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
                movieCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
                movieCollection.heightAnchor.constraint(equalToConstant: 297)
            ])
            
            leadingAnchor = movieCollection.bottomAnchor
            
            if i == self.movieCollectionsData.count - 1 {
                movieCollection.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerItemView",
                                                            for: indexPath) as? BannerItemView else {
                    return UICollectionViewCell()
        }
        
        cell.setUp(info: self.items[indexPath.item])
        
        return cell
    }
}

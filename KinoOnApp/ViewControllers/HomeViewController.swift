import Foundation
import UIKit

class HomeViewController: UIViewController {
    private struct HomeViewControllerConstants {
        static let bannerHeightMultiplier = CGFloat(0.3)
        static let movieCollectionIndent = CGFloat(30)
        static let movieCollectionHeight = CGFloat(297)
    }

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

    private let scrollView = UIScrollView(frame: .zero)

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
        self.navigationItem.title = "KINO|ON"

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        scrollView.layoutIfNeeded()

        setUpBannerView()

        MovieCollectionRepository().getHomePageCollection { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }

                switch result {
                case .success(let collection):
                    self.setupMovieCollections(collection: collection)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func setUpBannerView() {
        scrollView.addSubview(bannerView)

        bannerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        bannerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        bannerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        bannerView.heightAnchor.constraint(
                equalTo: scrollView.heightAnchor,
                multiplier: HomeViewControllerConstants.bannerHeightMultiplier).isActive = true
        bannerView.layoutIfNeeded()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = bannerView.bounds.size
        bannerView.setCollectionViewLayout(layout, animated: false)

        scrollView.contentSize = CGSize(width: bannerView.bounds.width, height: bannerView.bounds.height)
    }

    func setupMovieCollections(collection: [MovieCollection]) {
        var leadingAnchor = bannerView.bottomAnchor

        for i in 0..<collection.count {
            let movieCollection = MovieCollectionView(frame: .zero)

            movieCollection.fill(data: collection[i])

            scrollView.addSubview(movieCollection)
            movieCollection.translatesAutoresizingMaskIntoConstraints = false

            let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
            movieCollection.isUserInteractionEnabled = true
            movieCollection.addGestureRecognizer(singleTap)

            NSLayoutConstraint.activate([
                movieCollection.topAnchor.constraint(
                        equalTo: leadingAnchor,
                        constant: HomeViewControllerConstants.movieCollectionIndent),
                movieCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
                movieCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
                movieCollection.heightAnchor.constraint(
                        equalToConstant: HomeViewControllerConstants.movieCollectionHeight)
            ])

            leadingAnchor = movieCollection.bottomAnchor

            scrollView.contentSize = CGSize(width: scrollView.contentSize.width,
                    height: scrollView.contentSize.height
                            + HomeViewControllerConstants.movieCollectionHeight)
        }
    }

    @objc
    private func tapDetected() {
        self.navigationController?.pushViewController(FilmViewController(filmId: 2), animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {
}

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

import Foundation
import UIKit

class HomeViewController: UIViewController {
    private struct HomeViewControllerConstants {
        static let bannerHeightMultiplier = CGFloat(0.35)
        static let movieCollectionIndent = CGFloat(30)
        static let movieCollectionHeight = CGFloat(297)
    }

    private var items = [
        FilmBannerInfo(
                id: 6,
                title: "Убийство в восточном экспрессе",
                description:
                "Путешествие на одном из самых роскошных поездов Европы неожиданно превращается в одну из самых стильных и захватывающих загадок в истории.",
                img: "test_banner_img_1"),
        FilmBannerInfo(
                id: 9,
                title: "Джокер",
                description:
                "Готэм, начало 1980-х годов. Комик Артур Флек живет с больной матерью, которая с детства учит его «ходить с улыбкой».",
                img: "test_banner_img_2"),
        FilmBannerInfo(
                id: 422,
                title: "Зеленая книга",
                description:
                "Утонченный светский лев, богатый и талантливый музыкант нанимает в качестве водителя и телохранителя человека, который менее всего подходит для этой работы.",
                img: "test_banner_img_3"),
        FilmBannerInfo(
                id: 421,
                title: "Ford против Ferrari",
                description:
                "В начале 1960-х Генри Форд II принимает решение улучшить имидж компании и сменить курс на производство более модных автомобилей.",
                img: "test_banner_img_4"),
        FilmBannerInfo(
                id: 5,
                title: "Твое имя",
                description:
                "История о парне из Токио и девушке из провинции, которые обнаруживают, что между ними существует странная и необъяснимая связь.",
                img: "test_banner_img_5"), ]

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
        layout.minimumLineSpacing = 0
        bannerView.setCollectionViewLayout(layout, animated: false)

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        singleTap.cancelsTouchesInView = false
        bannerView.isUserInteractionEnabled = true
        bannerView.addGestureRecognizer(singleTap)

        scrollView.contentSize = CGSize(width: bannerView.frame.width, height: bannerView.frame.height)
    }

    func setupMovieCollections(collection: [MovieCollection]) {
        var topAnchor = bannerView.bottomAnchor

        for i in 0..<collection.count {
            let movieCollection = MovieCollectionView(frame: .zero)
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
            singleTap.cancelsTouchesInView = false
            movieCollection.fill(data: collection[i], action: singleTap)

            scrollView.addSubview(movieCollection)
            movieCollection.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                movieCollection.topAnchor.constraint(
                        equalTo: topAnchor,
                        constant: HomeViewControllerConstants.movieCollectionIndent),
                movieCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
                movieCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
                movieCollection.heightAnchor.constraint(
                        equalToConstant: HomeViewControllerConstants.movieCollectionHeight)
            ])

            topAnchor = movieCollection.bottomAnchor

            scrollView.contentSize = CGSize(width: scrollView.contentSize.width,
                    height: scrollView.contentSize.height
                            + HomeViewControllerConstants.movieCollectionHeight
                            + HomeViewControllerConstants.movieCollectionIndent)
        }

        scrollView.contentSize = CGSize(width: scrollView.contentSize.width,
                height: scrollView.contentSize.height
                        - HomeViewControllerConstants.movieCollectionIndent)
    }

    @objc
    private func tapDetected(sender: UITapGestureRecognizer) {
        if let movieCollection = sender.view as? UICollectionView {
            let tapLocation = sender.location(in: movieCollection)
            if let tapIndexPath = movieCollection.indexPathForItem(at: tapLocation),
               let tappedCell = movieCollection.cellForItem(at: tapIndexPath) {
                if let movieCard = tappedCell as? MovieCardView {
                    self.navigationController?.pushViewController(FilmViewController(filmId: movieCard.getId()), animated: true)
                } else if let movieCard = tappedCell as? BannerItemView {
                    self.navigationController?.pushViewController(FilmViewController(filmId: movieCard.info.id), animated: true)
                }
            }
        }
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

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
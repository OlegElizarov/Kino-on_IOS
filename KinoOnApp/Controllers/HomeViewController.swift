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
        
        setUpBannerView()
    }
    
    func setUpBannerView() {
        self.view.addSubview(bannerView)
 
//        TODO
//        let navController = self.navigationController
//        let topInset = (navController?.view.safeAreaInsets.top ?? 0)
//            + (navController?.navigationBar.frame.height ?? 0)
//        let topInset = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let topInset = UIApplication.shared.statusBarFrame.height
        
        bannerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bannerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        bannerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topInset).isActive = true
        bannerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        bannerView.layoutIfNeeded()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = bannerView.bounds.size
        
        bannerView.setCollectionViewLayout(layout, animated: false)
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

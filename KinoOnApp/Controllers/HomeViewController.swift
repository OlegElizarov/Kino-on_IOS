
import Foundation
import UIKit

class HomeViewController: UIViewController {
    lazy private var mainSliderView: UIScrollView = {
        let sc = UIScrollView(frame: .zero)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.isPagingEnabled = true
        sc.isScrollEnabled = true
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "KINO|ON"
        
        setMainSliderView()
    }
    
    func setMainSliderView() {
        self.view.addSubview(mainSliderView)
        
        mainSliderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainSliderView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        mainSliderView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mainSliderView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        
        let item0 = BannerItemView(frame: .zero)
        
        mainSliderView.addSubview(item0)

        item0.translatesAutoresizingMaskIntoConstraints = false
        item0.leadingAnchor.constraint(equalTo: mainSliderView.leadingAnchor).isActive = true
        item0.widthAnchor.constraint(equalTo: mainSliderView.widthAnchor).isActive = true
        item0.topAnchor.constraint(equalTo: mainSliderView.topAnchor).isActive = true
        item0.heightAnchor.constraint(equalTo: mainSliderView.heightAnchor).isActive = true
        item0.setUp()
    }
}

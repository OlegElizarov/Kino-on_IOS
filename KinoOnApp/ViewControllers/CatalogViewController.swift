import Foundation
import UIKit

struct LayoutConstants {
    static let sidePadding = CGFloat(20)
    static let paddingBetweenBlocks = CGFloat(30)
}

struct Colors {
    static let blue = #colorLiteral(red: 0.04649306834, green: 0.3764508665, blue: 0.578525126, alpha: 1)
    static let lightGray = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
    static let shadow = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
}

struct CatalogViewControllerConstants {
    static let headerHeight = CGFloat(62)
    static let segmentControlHeight = CGFloat(46)
    static let underlineViewHeight = CGFloat(2)
}

struct ChosenFilters {
    var genre: Int
    var year: Int
    var order: Int
}

enum FilterType {
    case Genre
    case Year
    case Order
}

let filterButtons = [
    "genre",
    "year",
    "order",
]

class CatalogViewController: UIViewController {
    
    private var filters: Filters = Filters(genre: [], year: [], order: [])
    private var currentTab = ContentType.Movies
    private var chosenFilters: ChosenFilters = ChosenFilters(genre: 0, year: 0, order: 0)
    
    private let headlineLabel = UILabel()
    
    private lazy var segmentedControlContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = Colors.shadow.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()

        segmentedControl.insertSegment(withTitle: "ФИЛЬМЫ", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "СЕРИАЛЫ", at: 1, animated: true)

        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.setBackgroundImage(.init(), for: .normal, barMetrics: .default)
        segmentedControl.setDividerImage(.init(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

        // Styles for the unselected segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "OpenSans-Regular", size: 16)!
        ], for: .normal)

        // Styles for the selected segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: Colors.blue,
            NSAttributedString.Key.font: UIFont(name: "OpenSans-Regular", size: 16)!
        ], for: .selected)

        // Set up event handler
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    // The underline view below the segmented control
    private lazy var bottomUnderlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = Colors.blue
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        return underlineView
    }()
    
    private var filterButtons: [FilterButtonView] = []
//    private var yearButton: FilterButtonView!
//    private var orderButton: FilterButtonView!

    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
        return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHeader()
        setupSegmentControl()
        setupFilters()
    }
    
    func setupHeader() {
        headlineLabel.text = "Каталог"
        headlineLabel.font = UIFont(name: "Montserrat-Bold", size: 24)
        
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headlineLabel)
        
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headlineLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: LayoutConstants.sidePadding),
            headlineLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: LayoutConstants.sidePadding),
            headlineLabel.heightAnchor.constraint(equalToConstant: CatalogViewControllerConstants.headerHeight)
        ])
    }

    func setupSegmentControl() {
        super.viewDidLoad()

        view.addSubview(segmentedControlContainerView)
        segmentedControlContainerView.addSubview(segmentedControl)
        segmentedControlContainerView.addSubview(bottomUnderlineView)

        NSLayoutConstraint.activate([
            segmentedControlContainerView.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor),
            segmentedControlContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControlContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            segmentedControlContainerView.heightAnchor.constraint(equalToConstant: CatalogViewControllerConstants.segmentControlHeight)
            ])

        // Constrain the segmented control to the container view
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: segmentedControlContainerView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedControlContainerView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: segmentedControlContainerView.centerYAnchor)
            ])

        NSLayoutConstraint.activate([
            bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: CatalogViewControllerConstants.underlineViewHeight),
            leadingDistanceConstraint,
            bottomUnderlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments))
            ])
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        changeSegmentedControlLinePosition()
    }

    // Change position of the underline
    private func changeSegmentedControlLinePosition() {
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.leadingDistanceConstraint.constant = leadingDistance
            self?.view.layoutIfNeeded()
        })
    }
    
    func setupFilters() {
        FilterRepository().getFilters(type: currentTab) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let filters):
                    self.filters = filters
                    self.chosenFilters = ChosenFilters(genre: 0, year: 0, order: 0)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func setFilter(filterType: FilterType, value: Int) {
        switch filterType {
        case FilterType.Genre:
            self.chosenFilters.genre = value
        case FilterType.Year:
            self.chosenFilters.year = value
        case FilterType.Order:
            self.chosenFilters.order = value
        }
    }
    
//    func setupFilterButtons() {
//        for (index, filterButton) in filterButtons.enumerated() {
//            filterButton.fillCell(value: filters[chosenFilters[filterButtons[index]]].name)
//            filterButton.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(filterButton)
//        }
//    }
}
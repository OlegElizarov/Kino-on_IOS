import Foundation
import UIKit

class FilmViewController: UIViewController {
    private struct FilmViewControllerConstants {
        static let imageHeightMultiplier = CGFloat(0.3)
        static let buttonHeight = CGFloat(40)
        static let smallIndent = CGFloat(10)
        static let radius = CGFloat(12)
    }

    private let filmId: Int
    private var trailerUrl: String
    private var titleImage = UIImageView(frame: .zero)
    private var trailerButton = UIButton(frame: .zero)
    private let filmRepository = FilmRepository()

    lazy private var filmView: FilmView = {
        let filmView = FilmView(frame: .zero)

        filmView.translatesAutoresizingMaskIntoConstraints = false

        return filmView
    }()

    init(filmId: Int) {
        self.filmId = filmId
        self.trailerUrl = ""
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        setUpTitleImage()
        setUpTrailerButton()
        setUpFilmInfo()

        filmRepository.getFilm(id: filmId) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }

                switch result {
                case .success(let film):
                    self.trailerUrl = film.trailerUrl
                    self.filmView.setUp(film: film)

                    self.filmRepository.downloadImage(url: film.imgUrl,
                            completion: { [weak self] result in
                                DispatchQueue.main.async {
                                    guard let self = self else {
                                        return
                                    }

                                    switch result {
                                    case .success(let image):
                                        self.titleImage.image = image
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                            })
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    private func setUpTitleImage() {
        self.view.addSubview(titleImage)

        titleImage.contentMode = UIView.ContentMode.scaleAspectFill
        titleImage.layer.cornerRadius = FilmViewControllerConstants.radius
        titleImage.translatesAutoresizingMaskIntoConstraints = false

        titleImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        titleImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        titleImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleImage.heightAnchor.constraint(equalTo: self.view.heightAnchor,
                multiplier: FilmViewControllerConstants.imageHeightMultiplier).isActive = true

        titleImage.layoutIfNeeded()
    }

    private func setUpTrailerButton() {
        self.view.addSubview(trailerButton)

        trailerButton.setTitle("Watch trailer", for: .normal)
        trailerButton.backgroundColor = .systemBlue
        trailerButton.layer.cornerRadius = FilmViewControllerConstants.radius

        trailerButton.addTarget(self, action: #selector(tapDetected), for: .touchUpInside)

        trailerButton.translatesAutoresizingMaskIntoConstraints = false
        trailerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                constant: FilmViewControllerConstants.smallIndent).isActive = true
        trailerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                constant: -FilmViewControllerConstants.smallIndent).isActive = true
        trailerButton.topAnchor.constraint(equalTo: self.titleImage.bottomAnchor,
                constant: FilmViewControllerConstants.smallIndent).isActive = true
        trailerButton.heightAnchor.constraint(equalToConstant: FilmViewControllerConstants.buttonHeight).isActive = true

        trailerButton.layoutIfNeeded()
    }

    private func setUpFilmInfo() {
        self.view.addSubview(filmView)

        filmView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        filmView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        filmView.topAnchor.constraint(equalTo: self.trailerButton.bottomAnchor,
                constant: FilmViewControllerConstants.smallIndent).isActive = true
        filmView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        filmView.layoutIfNeeded()
    }

    @objc
    private func tapDetected() {
        guard let appUrl = URL(string: "youtube://youtube.com/\(self.trailerUrl)") else {
            return
        }
        guard let webUrl = URL(string: "https://youtube.com/\(self.trailerUrl)") else {
            return
        }

        if UIApplication.shared.canOpenURL(appUrl) == true  {
            UIApplication.shared.open(appUrl)
        } else {
            UIApplication.shared.open(webUrl)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

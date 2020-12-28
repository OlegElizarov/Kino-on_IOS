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

    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

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

        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.layoutIfNeeded()

        scrollView.contentSize = CGSize(width: scrollView.contentSize.width,
                height: setUpTitleImage() +
                        setUpTrailerButton())
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
                    self.scrollView.contentSize.height += self.filmView.frame.height

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

        filmRepository.getReviews(filmId: filmId) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }

                switch result {
                case .success(let reviews):
                    let h = self.setUpReviews(reviews: reviews)
                    self.scrollView.contentSize.height += h
                    print("\(self.scrollView.contentSize.height) \(h)")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    private func setUpTitleImage() -> CGFloat {
        self.scrollView.addSubview(titleImage)

        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.contentMode = UIView.ContentMode.scaleAspectFill
        titleImage.clipsToBounds = true

        titleImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        titleImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        titleImage.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        titleImage.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor,
                multiplier: FilmViewControllerConstants.imageHeightMultiplier).isActive = true

        titleImage.layoutIfNeeded()

        return titleImage.frame.height
    }

    private func setUpTrailerButton() -> CGFloat {
        self.scrollView.addSubview(trailerButton)

        trailerButton.setTitle("Посмотреть трейлер", for: .normal)
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

        return trailerButton.frame.height
    }

    private func setUpFilmInfo() {
        self.scrollView.addSubview(filmView)

        filmView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        filmView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        filmView.topAnchor.constraint(equalTo: self.trailerButton.bottomAnchor,
                constant: FilmViewControllerConstants.smallIndent).isActive = true

        filmView.layoutIfNeeded()
    }

    private func setUpReviews(reviews: [Review]) -> CGFloat {
        var height = CGFloat(0)
        var topAnchor = filmView.bottomAnchor

        for item in reviews {
            let rev = ReviewView(frame: .zero)

            self.scrollView.addSubview(rev)

            rev.layer.cornerRadius = FilmViewControllerConstants.radius
            rev.translatesAutoresizingMaskIntoConstraints = false
            rev.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                    constant: FilmView.FilmViewConstants.indent).isActive = true
            rev.trailingAnchor.constraint(
                    equalTo: self.view.trailingAnchor,
                    constant: -FilmView.FilmViewConstants.indent).isActive = true
            rev.topAnchor.constraint(
                    equalTo: topAnchor,
                    constant: FilmView.FilmViewConstants.indent).isActive = true
            rev.layoutIfNeeded()

            rev.setUp(rev: item)
            rev.layoutIfNeeded()
            topAnchor = rev.bottomAnchor
            height += rev.frame.height + FilmView.FilmViewConstants.indent
        }

        return height
    }

    @objc
    private func tapDetected() {
        guard let appUrl = URL(string: "youtube://youtube.com/\(self.trailerUrl)") else {
            return
        }
        guard let webUrl = URL(string: "https://youtube.com/\(self.trailerUrl)") else {
            return
        }

        if UIApplication.shared.canOpenURL(appUrl) == true {
            UIApplication.shared.open(appUrl)
        } else {
            UIApplication.shared.open(webUrl)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

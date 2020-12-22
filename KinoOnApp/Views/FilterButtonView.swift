import Foundation
import UIKit

class FilterButtonView: UIView {
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupBackground()
        setupValueLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillCell(value: String) {
        label.text = value
    }
    
    func setupBackground() {
        self.backgroundColor = Colors.lightGray
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }
    
    func setupValueLabel() {
        label.font = UIFont(name: "OpenSans-Regular", size: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 23),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 35)
        ])
    }
}

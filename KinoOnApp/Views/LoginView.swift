import UIKit

enum StateLoginController {
    case login
    case signup
}

class ProfileLable: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = self.font.withSize(30)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

class PageTypeLable: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = self.font.withSize(22)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

class SubmitButton: UIButton {
    init(text: String) {
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 0.05882352941, green: 0.2980392157, blue: 0.5058823529, alpha: 1)
        self.setTitle(text, for: .normal)
        self.layer.cornerRadius = 16.0
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

class ToggleButton: UIButton {
    init(title: String, callback: @escaping (Bool) -> Void) {
        self.callback = callback

        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = self.titleLabel?.font.withSize(30.0)
//        self.setTitleColor(.red, for: .normal)
        self.addTarget(self, action: #selector(self.toggle), for: .touchUpInside)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("Oh,man....")
    }
    
    private let callback: (Bool) -> Void
    var isChecked = false
    
    @objc
    func toggle(_ sender: UIButton!) {
        isChecked = !isChecked
        if isChecked {
//            sender.setTitle("✓", for: .normal)
            sender.setTitle("🙉", for: .normal)

//            sender.setTitleColor(.green, for: .normal)
        } else {
//            sender.setTitle("X", for: .normal)
            sender.setTitle("🙈", for: .normal)

//            sender.setTitleColor(.red, for: .normal)
        }
        self.callback(isChecked)
    }
}

enum TypesTextFieldRightButtons {
    case authorize
    case settings
}

class InputField: UITextField {
    
    init(text: String, typeRightButton: TypesTextFieldRightButtons? = nil) {
        super.init(frame: .zero)
        self.placeholder = text

        createBorder()
        switch typeRightButton {
        case .authorize:
            self.isSecureTextEntry = true
            self.rightViewMode = .always
            let toggleButton = ToggleButton(title: "🙈", callback: setVisibility(isVisible:))
            self.rightView = toggleButton
            // прибивка направо
        case .settings:
            // наверняка у вас будут немного другие правые части у текст филда в профиле
            // в настройках или еще где-то, если нет, то уберете
            break
        default:
            break
        }

    }
    
    private let border = CALayer()
    
    private func setVisibility(isVisible: Bool) {
        self.isSecureTextEntry = !isVisible
    }

    func createBorder() {
//        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.systemGray5.cgColor
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        
        self.leftViewMode = .always
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = CGFloat(2.0)
        border.frame = CGRect(x: 0, y: self.frame.size.height-width,
                              width: self.frame.size.width, height: self.frame.size.height)
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("focused")
    }
    func textFieldDidEndEditing(textField: UITextField) {
        print("lost focus")
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createBorder()
    }
}

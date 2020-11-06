import UIKit

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

class LoginButton: UIButton {
    init(text: String) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.systemBlue
        self.setTitle(text, for: .normal)
        self.layer.cornerRadius = 10.0
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

class ToggleButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.red, for: .normal)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

class InputField: UITextField {
    init(text: String) {
        super.init(frame: .zero)
        self.placeholder = text
        createBorder()
    }
    
    init(text: String, rightButton: UIButton) {
        super.init(frame: .zero)
        self.placeholder = text
        self.rightViewMode = .always
        self.rightView = rightButton
        createBorder()
    }

    func createBorder() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.systemGray5.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        
        self.leftViewMode = .always
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

import UIKit

class ProfileViewController: UIViewController {
    //test
    var testUser: User = User(username: "testUser", email: "test", password: "123")
    
    var loginField: InputField!
    var passwordField: InputField!
    var repPasswordField: InputField!
    var loginButton: LoginButton!
    var profileLabel: ProfileLable!
    var loginLabel: PageTypeLable!
    var signUpLabel: PageTypeLable!
    var logTop: NSLayoutConstraint!
    var hello: UILabel!
    var state:StateProfileController = .login
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureLabel()
        configureInputs()
        configureLoginButton()
        configureMessageLabel()
        configureTypePage()
        
        setup()
    }
    
    @objc
    func toggle(_ sender: UIButton!) {
        isChecked = !isChecked
        if isChecked {
            sender.setTitle("✓", for: .normal)
            sender.setTitleColor(.green, for: .normal)
            passwordField.isSecureTextEntry.toggle()
        } else {
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.red, for: .normal)
            passwordField.isSecureTextEntry.toggle()
        }
    }
    
    @objc
    func loginButtonAction(sender: UIButton!) {
        switch state {
        case .login:
            if (loginField.text == testUser.email) && (passwordField.text == testUser.password) {
                hello.text = "Hello , \(testUser.username)!"
            } else {
                hello.text = "Wrong params!"
            }
            return
            
        case .signup:
            if passwordField.text != repPasswordField.text {
                hello.text = "Passwords do not match!"
                return
            }
            if loginField.text == testUser.email {
                hello.text = "User alredy exists"
            } else {
                hello.text = "Meet our new friend => mister\(loginField.text!) !"
            }
            return

        }
    }
    
    func setup() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc
    func swipeLeft(sender: UIButton!) {
        loginLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.3137254902, blue: 0.7450980392, alpha: 1)
        signUpLabel.textColor = .none
        loginButton.setTitle("ВОЙТИ", for: .normal)
        repPasswordField.isHidden = true
        state = .login
        self.view.layoutIfNeeded()

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        logTop.isActive = true

        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveLinear, .allowUserInteraction], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        print("left")
        print(state)
    }
    
    @objc
    func swipeRight(sender: UIButton!) {
        loginLabel.textColor = .none
        signUpLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.3137254902, blue: 0.7450980392, alpha: 1)
        loginButton.setTitle("СОЗДАТЬ АККАУНТ", for: .normal)
        repPasswordField.isHidden = false
        state = .signup
        self.view.layoutIfNeeded()
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        logTop.isActive = false
        loginButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive = true
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveLinear, .allowUserInteraction], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        print("right")
        print(state)
    }
    
    private func configureLabel() {
        profileLabel = ProfileLable(text: "Аккаунт")
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.profileLabel!)
        
        profileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        profileLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        profileLabel.widthAnchor.constraint(equalToConstant: 360).isActive = true
        profileLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    private func configureInputs() {
        loginField = InputField(text: "Логин")
        view.addSubview(self.loginField!)
        
        passwordField = InputField(text: "Пароль", typeRightButton: .authorize)
        view.addSubview(self.passwordField!)
        
        loginField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        loginField.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        loginField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loginField.widthAnchor.constraint(equalToConstant: 360).isActive = true
        loginField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordField.topAnchor.constraint(equalTo: view.topAnchor, constant: 190).isActive = true
        passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        passwordField.widthAnchor.constraint(equalToConstant: 360).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        repPasswordField = InputField(text: "Повторите пароль", typeRightButton: .authorize)
        view.addSubview(self.repPasswordField!)
        repPasswordField.translatesAutoresizingMaskIntoConstraints = false
        
        repPasswordField.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        repPasswordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        repPasswordField.widthAnchor.constraint(equalToConstant: 360).isActive = true
        repPasswordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        repPasswordField.isHidden = true
        
    }
    
    private func configureLoginButton() {
        loginButton = LoginButton(text: "ВОЙТИ")
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton!)
        
        logTop = loginButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 270)
        logTop.isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 360).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func configureMessageLabel() {
        hello = UILabel()
        hello.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(hello)
        hello.topAnchor.constraint(equalTo: view.topAnchor, constant: 330).isActive = true
        hello.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        hello.widthAnchor.constraint(equalToConstant: 360).isActive = true
        hello.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureTypePage() {
        loginLabel = PageTypeLable(text: "Войти")
        signUpLabel = PageTypeLable(text: "Создать Аккаунт")
        loginLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.3137254902, blue: 0.7450980392, alpha: 1)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self.loginLabel!)
        view.addSubview(self.signUpLabel!)
        
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        loginLabel.widthAnchor.constraint(equalToConstant: 360).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 187).isActive = true
        signUpLabel.widthAnchor.constraint(equalToConstant: 360).isActive = true
        signUpLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

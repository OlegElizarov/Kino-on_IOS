import UIKit

class ProfileViewController: UIViewController {
    //test
    var testUser: User = User(username: "testUser", email: "test", password: "123")
    
    private var loginField: InputField!
    private var passwordField: InputField!
    private var repPasswordField: InputField!
    private var loginButton: LoginButton!
    private var profileLabel: ProfileLable!
    private var loginLabel: PageTypeLable!
    private var signUpLabel: PageTypeLable!
    private var logTopPass: NSLayoutConstraint!
    private var logTopRep: NSLayoutConstraint!
    private var hello: UILabel!
    private var state: StateProfileController = .login
    private var isChecked = false
    
//    var segm: UISegmentedControl!
//    private var ofs1: NSLayoutConstraint!
//    private var ofs2: NSLayoutConstraint!
//    private var ofs3: NSLayoutConstraint!
//
//    let segmentindicator: UIView = {
//
//        let vie = UIView()
//
//        vie.translatesAutoresizingMaskIntoConstraints = false
//        vie.backgroundColor = UIColor.yellow
//
//        return vie
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureLabel()
        configureTypePage()
        configureInputs()
        configureLoginButton()
        configureMessageLabel()
        
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
                hello.text = "Meet our new friend => mister \(loginField.text!) !"
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
        print("left")
        loginState()
    }
    
    @objc
    func swipeRight(sender: UIButton!) {
        print("right")
        signupState()
    }
    
    @objc
    func loginState() {
        loginLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.3137254902, blue: 0.7450980392, alpha: 1)
        signUpLabel.textColor = .none
        loginButton.setTitle("ВОЙТИ", for: .normal)
        repPasswordField.isHidden = true
        state = .login
        self.view.layoutIfNeeded()
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        logTopRep.isActive = false
        logTopPass.isActive = true
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveLinear, .allowUserInteraction], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        print(state)
    }
    
    @objc
    func signupState() {
        loginLabel.textColor = .none
        signUpLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.3137254902, blue: 0.7450980392, alpha: 1)
        loginButton.setTitle("СОЗДАТЬ АККАУНТ", for: .normal)
        repPasswordField.isHidden = false
        state = .signup
        self.view.layoutIfNeeded()
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        logTopPass.isActive = false
        logTopRep.isActive = true
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveLinear, .allowUserInteraction], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        print(state)
    }
    
    private func configureLabel() {
        profileLabel = ProfileLable(text: "Аккаунт")
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.profileLabel!)
        
        profileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        profileLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        profileLabel.widthAnchor.constraint(equalToConstant: 360).isActive = true
        profileLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureTypePage() {
        loginLabel = PageTypeLable(text: "Войти")
        signUpLabel = PageTypeLable(text: "Создать Аккаунт")
        loginLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.3137254902, blue: 0.7450980392, alpha: 1)
        
        let tapLogin = UITapGestureRecognizer(target: self, action: #selector(loginState))
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(tapLogin)
        let tapSignUp = UITapGestureRecognizer(target: self, action: #selector(signupState))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(tapSignUp)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self.loginLabel!)
        view.addSubview(self.signUpLabel!)
        
        [loginLabel, signUpLabel].forEach {
            $0?.widthAnchor.constraint(equalToConstant: 360).isActive = true
            $0?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        loginLabel.topAnchor.constraint(equalTo: profileLabel.topAnchor, constant: 60).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        
        signUpLabel.topAnchor.constraint(equalTo: loginLabel.topAnchor).isActive = true
        signUpLabel.leftAnchor.constraint(equalTo: loginLabel.leftAnchor, constant: 127).isActive = true
    }
    
    private func configureInputs() {
        loginField = InputField(text: "Логин")
        passwordField = InputField(text: "Пароль", typeRightButton: .authorize)
        repPasswordField = InputField(text: "Повторите пароль", typeRightButton: .authorize)

        view.addSubview(self.loginField!)
        view.addSubview(self.passwordField!)
        view.addSubview(self.repPasswordField!)

        loginField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        repPasswordField.translatesAutoresizingMaskIntoConstraints = false
        
        [loginField, passwordField, repPasswordField].forEach {
            $0?.widthAnchor.constraint(equalToConstant: 360).isActive = true
            $0?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        loginField.topAnchor.constraint(equalTo: loginLabel.topAnchor, constant: 60).isActive = true
        loginField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        passwordField.topAnchor.constraint(equalTo: loginField.topAnchor, constant: 60).isActive = true
        passwordField.leftAnchor.constraint(equalTo: loginField.leftAnchor).isActive = true
                
        repPasswordField.topAnchor.constraint(equalTo: passwordField.topAnchor, constant: 60).isActive = true
        repPasswordField.leftAnchor.constraint(equalTo: passwordField.leftAnchor).isActive = true
        
        repPasswordField.isHidden = true
        
    }
    
    private func configureLoginButton() {
        loginButton = LoginButton(text: "ВОЙТИ")
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton!)
        
        logTopPass = loginButton.topAnchor.constraint(equalTo: passwordField.topAnchor, constant: 70)
        logTopPass.isActive = true
        logTopRep = loginButton.topAnchor.constraint(equalTo: repPasswordField.topAnchor, constant: 70)
        logTopRep.isActive = false
        
        loginButton.leftAnchor.constraint(equalTo: loginField.leftAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 360).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func configureMessageLabel() {
        hello = UILabel()
        hello.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(hello)
        hello.topAnchor.constraint(equalTo: loginButton.topAnchor, constant: 30).isActive = true
        hello.leftAnchor.constraint(equalTo: loginButton.leftAnchor).isActive = true
        hello.widthAnchor.constraint(equalToConstant: 360).isActive = true
        hello.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
//        segm = UISegmentedControl(items: ["One", "Two", "Three"])
//        segm.selectedSegmentIndex = 0
//        segm.translatesAutoresizingMaskIntoConstraints = false
//        segm.backgroundColor = .clear
//        segm.tintColor = .clear
//        segm.setTitleTextAttributes([NSAttributedString.Key.font:
//                                        UIFont(name: "AvenirNextCondensed-Medium",
//                                               size: 20)!,
//                                     NSAttributedString.Key.foregroundColor:
//                                        UIColor.lightGray], for: .normal)
//        segm.setTitleTextAttributes([NSAttributedString.Key.font:
//                                        UIFont(name: "AvenirNextCondensed-Medium",
//                                               size: 24)!,
//                                     NSAttributedString.Key.foregroundColor:
//                                        #colorLiteral(red: 0.1176470588, green: 0.3137254902, blue: 0.7450980392, alpha: 1)], for: .selected)
//
//        self.view.addSubview(segm)
//        segm.topAnchor.constraint(equalTo: loginButton.topAnchor, constant: 80).isActive = true
//        segm.leftAnchor.constraint(equalTo: loginButton.leftAnchor).isActive = true
//        segm.widthAnchor.constraint(equalToConstant: 360).isActive = true
//        segm.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        segm.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
//
//        self.view.addSubview(segmentindicator)
//        segmentindicator.topAnchor.constraint(equalTo: segm.bottomAnchor, constant: 2).isActive = true
//        ofs1 = segmentindicator.leftAnchor.constraint(equalTo: segm.leftAnchor, constant: 10)
//        ofs1.isActive = true
//        ofs2 = segmentindicator.leftAnchor.constraint(equalTo: segm.leftAnchor, constant: 130)
//        ofs2.isActive = false
//        ofs3 = segmentindicator.leftAnchor.constraint(equalTo: segm.leftAnchor, constant: 250)
//        ofs3.isActive = false
//
//        segmentindicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        segmentindicator.heightAnchor.constraint(equalToConstant: 2).isActive = true
//
    }
    
//    @objc
//    func indexChanged(_ sender: UISegmentedControl) {
//        let numberOfSegments = CGFloat(segm.numberOfSegments)
//        let selectedIndex = CGFloat(sender.selectedSegmentIndex)
//        switch selectedIndex {
//        case 0:
//            ofs2.isActive = false
//            ofs3.isActive = false
//            ofs1.isActive = true
//        case 1:
//            ofs1.isActive = false
//            ofs3.isActive = false
//            ofs2.isActive = true
//        case 2:
//            ofs1.isActive = false
//            ofs2.isActive = false
//            ofs3.isActive = true
//        default: break
//        }
//
//        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveLinear, .allowUserInteraction], animations: {
//            self.view.layoutIfNeeded()
//        }, completion: nil)
//    }

}

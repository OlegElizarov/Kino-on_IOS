import UIKit

class ProfileViewController: UIViewController {
    //test
    var testUser: User = User(username: "testUser", email: "test", password: "123")
    
    var loginField: InputField!
    var passwordField: InputField!
    var loginButton: LoginButton!
    var profileLabel: ProfileLable!
    var hello: UILabel!
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureLabel()
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
        if (loginField.text == testUser.email) && (passwordField.text == testUser.password) {
            hello.text = "Hello , \(testUser.username)!"
        } else {
            hello.text = "Wrong params!"
        }
    }

     func setup() {
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
        
        loginField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        loginField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loginField.widthAnchor.constraint(equalToConstant: 360).isActive = true
        loginField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordField.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        passwordField.widthAnchor.constraint(equalToConstant: 360).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    private func configureLoginButton() {
        loginButton = LoginButton(text: "Войти")
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton!)
        
        loginButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 240).isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 360).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func configureMessageLabel() {
        hello = UILabel()
        hello.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(hello)
        hello.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        hello.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        hello.widthAnchor.constraint(equalToConstant: 360).isActive = true
        hello.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

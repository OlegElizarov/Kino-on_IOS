import UIKit

class ProfileViewController: UIViewController {
    //test
    var testUser: User = User(username: "testUser", email: "test", password: "123")
    
    var loginField: InputField!
    var passwordField: InputField!
    var loginButton: LoginButton!
    var profileLabel: ProfileLable!
    var hello: UILabel!
    var toggleButton: ToggleButton!
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureLabel()
        configureToggle()
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
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            profileLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            profileLabel.widthAnchor.constraint(equalToConstant: 360),
            profileLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func configureInputs() {
        loginField = InputField(text: "Логин")
        view.addSubview(self.loginField!)
        
        passwordField = InputField(text: "Пароль", rightButton: toggleButton)
        view.addSubview(self.passwordField!)
        
        loginField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            loginField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            loginField.widthAnchor.constraint(equalToConstant: 360),
            loginField.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            passwordField.widthAnchor.constraint(equalToConstant: 360),
            passwordField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureToggle() {
        toggleButton  = ToggleButton(title: "X")
        toggleButton.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        toggleButton.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            toggleButton.widthAnchor.constraint(equalToConstant: 30),
            toggleButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureLoginButton() {
        loginButton = LoginButton(text: "Войти")
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton!)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 240),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 360),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureMessageLabel() {
        hello = UILabel()
        hello.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(hello)
        NSLayoutConstraint.activate([
            hello.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            hello.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            hello.widthAnchor.constraint(equalToConstant: 360),
            hello.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

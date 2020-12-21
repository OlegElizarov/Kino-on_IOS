import UIKit

class UserViewController: UIViewController {
    private var userLable: ProfileLable!
    private var usernameLabel: UILabel!
    private var loginInputField: InputField!
    private var emailInputField: InputField!
    private var saveButton: SubmitButton!
    private var avatar: UIImageView!
    private var logoutButton: SubmitButton!
    var parentController: TabBarController!
    
    var userData: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        modalTransitionStyle = .flipHorizontal

        configureLabel()
        configureUserData()
        configureInputs()
        configureSaveButton()
        configureLogoutButton()
    }
    
    private func configureLabel() {
        userLable = ProfileLable(text: "Профиль")
        userLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.userLable!)
        
        userLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        userLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        userLable.widthAnchor.constraint(equalToConstant: 360).isActive = true
        userLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    private func configureUserData() {
        usernameLabel = UILabel()
        
        guard let user = UserDatabase().getUserData() else {
            usernameLabel.text = "EMPTY"
            return
        }
        self.userData = user
        usernameLabel.text = user.username
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.usernameLabel!)
        usernameLabel.backgroundColor = .lightGray
        usernameLabel.textAlignment = NSTextAlignment.center
        usernameLabel.topAnchor.constraint(equalTo: userLable.topAnchor, constant: 250).isActive = true
        
        usernameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        avatar = UIImageView()
        avatar.image = UIImage(named: "test_banner_img")
        
        avatar.layer.borderWidth = 1
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.black.cgColor
        avatar.layer.cornerRadius = 50.0
        avatar.clipsToBounds = true
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.avatar!)
        
        avatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        avatar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        avatar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func configureInputs() {
        loginInputField = InputField(text: "")
        loginInputField.text = userData.username
        
        emailInputField = InputField(text: "")
        emailInputField.text = userData.email
        
        loginInputField.translatesAutoresizingMaskIntoConstraints = false
        emailInputField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginInputField)
        view.addSubview(emailInputField)
        
        [loginInputField, emailInputField ].forEach {
            $0?.widthAnchor.constraint(equalToConstant: 360).isActive = true
            $0?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        loginInputField.topAnchor.constraint(equalTo: usernameLabel.topAnchor, constant: 60).isActive = true
        loginInputField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        emailInputField.topAnchor.constraint(equalTo: loginInputField.topAnchor, constant: 60).isActive = true
        emailInputField.leftAnchor.constraint(equalTo: loginInputField.leftAnchor).isActive = true
    }
    
    private func configureSaveButton() {
        saveButton = SubmitButton(text: "СОХРАНИТЬ")
        saveButton.addTarget(self, action: #selector(saveUserFields), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton!)
        
        saveButton.topAnchor.constraint(equalTo: emailInputField.topAnchor, constant: 80).isActive = true
        saveButton.leftAnchor.constraint(equalTo: emailInputField.leftAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 360).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func configureLogoutButton() {
        logoutButton = SubmitButton(text: "ВЫЙТИ")
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton!)
        logoutButton.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        logoutButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20).isActive = true
        logoutButton.leftAnchor.constraint(equalTo: saveButton.leftAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 360).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc
    func saveUserFields() {
        if (loginInputField.text == userData.username) && (emailInputField.text == userData.email) {
            print("Nothing to change")
            return
        }
        ProfileRepository().saveSettings(username: loginInputField.text ?? "",
                                         email: emailInputField.text ?? "", password: "") {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    UserDatabase().saveUserData(user: user)
                    self.userData = user
                    self.setData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @objc
    func logout() {
        ProfileRepository().logout {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print(data)
                    self.navigationController!.pushViewController(ProfileViewController(), animated: true)
                    
                    let newController = ProfileViewController()
                    newController.parentController = self.parentController
                    self.parentController.changeItemController(newController: newController)
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        //TODO: clean storage
        UserDatabase().removeUser()
    }
    
    private func setData() {
        usernameLabel.text = userData.username
        loginInputField.text = userData.username
        emailInputField.text = userData.email
    }
}

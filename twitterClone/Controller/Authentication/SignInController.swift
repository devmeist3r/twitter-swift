import MaterialComponents
import UIKit

class SignInController: UIViewController {
    
    // MARK: - Properties
    
    var textFieldControllerFloatingEmail = MDCTextInputControllerUnderline()
    var textFieldControllerFloatingPass = MDCTextInputControllerUnderline()
    
    private lazy var labelTitle: UILabel = {
        let label = ComponentsFactory.labelBase(text: "Entrar", nameFont: "Roboto-Bold", sizeFont: 36.0, textColor: .white)
        return label
    }()
  
    private lazy var emailTextField: MDCTextField = {
        let textFieldFloating = ComponentsFactory.textFieldInput(placeholder: "E-mail", keyboardType: .emailAddress)
        textFieldControllerFloatingEmail = ComponentsFactory.floatLabel(textFieldFloating: textFieldFloating)
        return textFieldFloating
    }()
    
    private lazy var passwordTextField: MDCTextField = {
        let textFieldFloating = ComponentsFactory.textFieldInput(placeholder: "Password", keyboardType: .emailAddress)
        textFieldFloating.isSecureTextEntry = true
        textFieldControllerFloatingPass = ComponentsFactory.floatLabel(textFieldFloating: textFieldFloating)
        return textFieldFloating
    }()
    
    private lazy var buttonMdc: MDCButton = {
        let button = ComponentsFactory.buttonBase(title: "Entrar")
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(handleButtonLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Não tem uma conta? ", attributes: [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Clique aqui", attributes: [NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
   
    // MAKR: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Selectors
    @objc func handleButtonLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService().logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error logging in \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: Successful log in..")
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            guard let tab = window.rootViewController as? MainTabController else { return }
            
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleShowSignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(labelTitle)
        labelTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
        labelTitle.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, buttonMdc])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        
        view.addSubview(stack)
        stack.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        stack.center(inView: view)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
    @objc func keyboardShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                UIView.animate(withDuration: duration) {
                    self.view.frame = CGRect(
                        x: UIScreen.main.bounds.origin.x,
                        y: UIScreen.main.bounds.origin.y,
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height - keyboardSize.height
                    )
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardHide(notification: NSNotification) {
        
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: duration) {
                self.view.frame = UIScreen.main.bounds
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
}

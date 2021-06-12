//
//  SignUpController.swift
//  twitterClone
//
//  Created by Lucas Inocencio on 26/08/20.
//  Copyright © 2020 Lucas Inocencio. All rights reserved.
//

import Firebase
import MaterialComponents
import UIKit

class SignUpController: UIViewController {
    
    // MARK: - Properties
    var textFieldControllerFloatingEmail = MDCTextInputControllerUnderline()
    var textFieldControllerFloatingPass = MDCTextInputControllerUnderline()
    var textFieldControllerFloatingFullname = MDCTextInputControllerUnderline()
    var textFieldControllerFloatingUsername = MDCTextInputControllerUnderline()
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private lazy var backBtn: UIButton = {
        let button = UIButton()
        let image = #imageLiteral(resourceName: "arrow_back")
        image.withTintColor(UIColor.white)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return button
    }()
    
    private lazy var plusPhotoBtn: UIButton = {
        let button = UIButton()
        let image = #imageLiteral(resourceName: "camera")
        image.withTintColor(UIColor.white)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = ComponentsFactory.labelBase(text: "Criar conta", nameFont: "Roboto-Bold", sizeFont: 36.0, textColor: .white)
        return label
    }()
    
    private lazy var emailTextField: MDCTextField = {
        let textFieldFloating = ComponentsFactory.textFieldInput(placeholder: "E-mail", keyboardType: .emailAddress)
        textFieldControllerFloatingEmail = ComponentsFactory.floatLabel(textFieldFloating: textFieldFloating)
        return textFieldFloating
    }()
    
    private lazy var passwordTextField: MDCTextField = {
        let textFieldFloating = ComponentsFactory.textFieldInput(placeholder: "Senha", keyboardType: .emailAddress)
        textFieldFloating.isSecureTextEntry = true
        textFieldControllerFloatingPass = ComponentsFactory.floatLabel(textFieldFloating: textFieldFloating)
        return textFieldFloating
    }()
    
    private lazy var fullNameTextField: MDCTextField = {
        let textFieldFloating = ComponentsFactory.textFieldInput(placeholder: "Nome completo", keyboardType: .emailAddress)
        textFieldControllerFloatingFullname = ComponentsFactory.floatLabel(textFieldFloating: textFieldFloating)
        return textFieldFloating
    }()
    
    private lazy var usernameTextField: MDCTextField = {
        let textFieldFloating = ComponentsFactory.textFieldInput(placeholder: "Apelido", keyboardType: .emailAddress)
        textFieldControllerFloatingUsername = ComponentsFactory.floatLabel(textFieldFloating: textFieldFloating)
        return textFieldFloating
    }()
    
    private lazy var buttonMdc: MDCButton = {
        let button = ComponentsFactory.buttonBase(title: "Cadastrar")
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(handleButtonSignUp), for: .touchUpInside)
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
    
    @objc func handleButtonSignUp() {
        guard let profileImage = profileImage else {
            print("DEBUG: Please select a profile image...")
            return
        }
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        
        let credentials = AuthCredentials(profileImage: profileImage, email: email, password: password, fullname: fullname, username: username)
        
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            guard let tab = window.rootViewController as? MainTabController else { return }
            
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    @objc func handleShowSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(backBtn)
        backBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor,  left: view.leftAnchor, paddingTop: 20, paddingLeft: 10)
        
        view.addSubview(labelTitle)
        labelTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        labelTitle.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, usernameTextField, buttonMdc])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        stack.center(inView: view)
        
        view.addSubview(plusPhotoBtn)
        plusPhotoBtn.setDimensions(width: 80, height: 80)
        plusPhotoBtn.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -10).isActive = true
        plusPhotoBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
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

// MARK: - UIImagePickerControllerDelegate

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        
        self.profileImage = profileImage
        
        plusPhotoBtn.layer.cornerRadius = 80 / 2
        plusPhotoBtn.layer.masksToBounds = true
        plusPhotoBtn.imageView?.contentMode = .scaleAspectFill
        plusPhotoBtn.imageView?.clipsToBounds = true
        plusPhotoBtn.layer.borderColor = UIColor.white.cgColor
        plusPhotoBtn.layer.borderWidth = 3
        
        self.plusPhotoBtn.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}



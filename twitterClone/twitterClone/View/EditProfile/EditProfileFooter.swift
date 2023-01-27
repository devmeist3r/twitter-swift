import UIKit

protocol EditProfileFooterDelegate: AnyObject  {
    func handleLogout()
}

class EditProfileFooter: UIView {
    
    // MARK: - Properties
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGOUT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    weak var delegate: EditProfileFooterDelegate?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoutButton)
        logoutButton.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoutButton.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleLogout() {
        self.delegate?.handleLogout()
    }
}

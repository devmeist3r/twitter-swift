//
//  ConversationsController.swift
//  twitterClone
//
//  Created by Lucas Inocencio on 26/08/20.
//  Copyright © 2020 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase

class ConversationsController: UIViewController {
    
    // MARK: - Properties
    let btnSignOut: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignout), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleSignout() {
        do {
            try? Auth.auth().signOut()
            let controller = SignInController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
        } catch {
            print("Erro ao sair")
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemFill
        navigationItem.title = "Conversations"
        
        view.addSubview(btnSignOut)
        NSLayoutConstraint.activate([
            btnSignOut.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btnSignOut.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    
}

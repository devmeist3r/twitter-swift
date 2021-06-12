//
//  NotificationsController.swift
//  twitterClone
//
//  Created by Lucas Inocencio on 26/08/20.
//  Copyright © 2020 Lucas Inocencio. All rights reserved.
//

import UIKit

class NotificationsController: UIViewController {
    
    // MARK: - Properties
    
     // MARK: - Lifecycle

       override func viewDidLoad() {
           super.viewDidLoad()
           
           configureUI()
       }
       
       // MARK: - Helpers
       func configureUI() {
           view.backgroundColor = .systemFill
           navigationItem.title = "Notifications"
       }
    
}

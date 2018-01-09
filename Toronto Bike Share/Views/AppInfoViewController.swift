//
//  AppInfoViewController.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-05.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import UIKit

final class AppInfoViewController: UIViewController {    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBlurEffect(using: .extraLight)
        view.addShadow()
    }
}

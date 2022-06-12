//
//  Color.swift
//  UIKitTesting
//
//  Created by Richard Witherspoon on 6/11/22.
//

import UIKit

class ColorVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Color"
        view.backgroundColor = .systemOrange
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel){ [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done){ [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
}

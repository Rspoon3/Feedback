//
//  Details.swift
//  UIKitTesting
//
//  Created by Richard Witherspoon on 6/11/22.
//

import UIKit

class DetailsVC: UIViewController {
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Details"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = "Placeholder Text"
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add){ [weak self] _ in
            self?.presentColorVC()
        }
    }
    
    private func presentColorVC() {
        let vc = ColorVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.definesPresentationContext = true
        nav.modalPresentationStyle = .currentContext
        present(nav, animated: true)
    }
}





//
//  Main.swift
//  UIKitTesting
//
//  Created by Richard Witherspoon on 6/11/22.
//

import UIKit

class MainVC: UITableViewController {
    let numbers = Array(0..<10).map({"Value \($0)"})

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        view.backgroundColor = .systemBackground
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = numbers[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let vc = DetailsVC()
        let nav = UINavigationController(rootViewController: vc)

        showDetailViewController(nav, sender: nil)
    }
}

//
//  ViewController.swift
//  Feedback
//
//  Created by Richard Witherspoon on 6/8/22.
//

import UIKit


class ViewController: UIViewController, UISplitViewControllerDelegate{
    let main = MainVC()
    let details = DetailsVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSplitVC()
    }
    
    private func configureSplitVC(){
        let split = UISplitViewController(style: .doubleColumn)

        addChild(split)
        view.addSubview(split.view)
        split.view.frame = view.bounds
        split.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        split.didMove(toParent: self)
        split.delegate = self
        split.minimumPrimaryColumnWidth   = 400
        split.maximumPrimaryColumnWidth   = 400
        split.preferredPrimaryColumnWidth = 400
        split.presentsWithGesture = false
        split.preferredDisplayMode = .oneBesideSecondary
        split.preferredSplitBehavior = .tile
        
        split.setViewController(main, for: .primary)
        split.setViewController(details, for: .secondary)
    }
    
    override func overrideTraitCollection(forChild childViewController: UIViewController) -> UITraitCollection? {
        super.overrideTraitCollection(forChild: childViewController)
        return .init(horizontalSizeClass: view.frame.width >= 800 ? .regular : .compact)
    }
    
    
    //MARK: - UISplitViewControllerDelegate
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        let navs = svc.viewControllers.compactMap {$0 as? UINavigationController }
        let vcs = navs.flatMap(\.viewControllers)
        
        guard let details = vcs.compactMap({$0 as? DetailsVC}).first else {
            return .primary
        }
        
        return details.presentedViewController == nil ? .primary : .secondary
    }
}

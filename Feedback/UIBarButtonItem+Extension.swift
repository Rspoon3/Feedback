//
//  UIBarButtonItem+Extension.swift
//  UIKitTesting
//
//  Created by Richard Witherspoon on 6/11/22.
//

import UIKit

extension UIBarButtonItem{
    public convenience init(systemItem: UIBarButtonItem.SystemItem, tintColor: UIColor? = nil, handler: @escaping UIActionHandler){
        let action = UIAction(handler: handler)
        self.init(systemItem: systemItem, primaryAction: action)
        self.tintColor = tintColor
    }
}

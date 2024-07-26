//
//  UIViewController+Ext.swift
//  MyLocation
//
//  Created by Artyom Petrichenko on 25.07.2024.
//

import Foundation
import UIKit

extension UIViewController {
    func addChildVC(childVC: UIViewController, layoutBlock: () -> Void) {
        addChild(childVC)
        view.addSubview(childVC.view)
        layoutBlock()
        childVC.didMove(toParent: self)
    }
    
    func removeChildVC(childVC: UIViewController) {
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }
}

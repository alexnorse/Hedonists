//
//  VC + Ext.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/19/21.
//

import UIKit

extension UIViewController {
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView      = EmptyStateView(message: message)
        emptyStateView.frame    = view.bounds
        view.addSubview(emptyStateView)
    }
}

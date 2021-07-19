//
//  TabBarVC.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/19/21.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: Fonts.tabBarItems!],
            for: .normal)
    }
}

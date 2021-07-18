//
//  TableView + Ext.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/18/21.
//

import UIKit

extension UITableView {
    
    func removeExcessCells () {
        tableFooterView = UIView(frame: .zero)
    }
}

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
    
    
    func setEmptyState(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: self.bounds.size.width,
                                                 height: self.bounds.size.height))
        
        messageLabel.text                        = message
        messageLabel.numberOfLines               = 0
        messageLabel.textColor                   = .secondaryLabel
        messageLabel.lineBreakMode               = .byTruncatingTail
        messageLabel.textAlignment               = .center
        messageLabel.font                        = Fonts.keyAccents
        messageLabel.sizeToFit()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
}

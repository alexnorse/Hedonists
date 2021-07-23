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
    
    
    func tableSeparator() {
        self.separatorStyle = .none
    }
    
    
    func setEmptyState(_ message: String) {
        
        let rectangle = CGRect(origin: CGPoint(x: 0, y: self.center.y),
                               size: CGSize(width: self.bounds.width, height: 100))
        
        let messageLabel = UILabel(frame: rectangle)
        
        messageLabel.center         = self.center
        messageLabel.text           = message
        messageLabel.numberOfLines  = 0
        messageLabel.textColor      = .secondaryLabel
        messageLabel.lineBreakMode  = .byTruncatingTail
        messageLabel.textAlignment  = .center
        messageLabel.font           = Fonts.bodyAccents
        messageLabel.sizeToFit()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(messageLabel)
        self.bringSubviewToFront(messageLabel)
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

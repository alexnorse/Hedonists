//
//  EmptyStateView.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/19/21.
//

import UIKit

class EmptyStateView: UIView {

    let messageLabel = UILabel(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func configure() {
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        messageLabel.font = Fonts.keyAccents
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor  .constraint(equalTo: self.centerYAnchor, constant: -40),
            messageLabel.leadingAnchor  .constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor .constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor   .constraint(equalToConstant: 200),
        ])
    }
}

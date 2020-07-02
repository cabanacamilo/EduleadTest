//
//  EmptyTableView.swift
//  EduleadTest
//
//  Created by Camilo Cabana on 2/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setEmptyView(message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = UILabel()
        emptyView.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.font = .systemFont(ofSize: 35)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor), messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)])
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

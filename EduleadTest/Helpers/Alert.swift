//
//  Alert.swift
//  EduleadTest
//
//  Created by Camilo Cabana on 2/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class Alert {
    
    func errorAlert(_ vc: UIViewController,title: String, messege: String) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}

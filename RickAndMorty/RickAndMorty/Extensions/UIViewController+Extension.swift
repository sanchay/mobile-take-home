//
//  UIViewController+Extension.swift
//  RickAndMorty
//
//  Created by Sanchay on 2019-08-14.
//  Copyright © 2019 Sanchay. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

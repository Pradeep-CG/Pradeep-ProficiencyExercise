//
//  CanadaViewControllerExtension.swift
//  Pradeep-ProficiencyExercise
//
//  Created by Pradeep on 09/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import Foundation
import UIKit

extension CanadaViewController {
    
    func presentSingleButtonDialog() {
        // create the alert
        let alert = UIAlertController(title: Constants.messageTitle, message: Constants.messageBody, preferredStyle: UIAlertController.Style.alert)
         // add an action (button)
        alert.addAction(UIAlertAction(title: Constants.alertOk, style: UIAlertAction.Style.default) { _ in
            self.removeSpinnerView()
        }
        )
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    func removeSpinnerView() {
        // remove the spinner view controller
        self.child.willMove(toParent: nil)
        self.child.view.removeFromSuperview()
        self.child.removeFromParent()
    }
}

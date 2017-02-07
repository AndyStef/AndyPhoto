//
//  StartViewController.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/7/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

protocol RedirectToMainScreenDelegate {
    func presentMainScreen()
}

class StartViewController: UIViewController, RedirectToMainScreenDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebView" {
            let navigationViewController = segue.destination as? UINavigationController
            let authViewController = navigationViewController?.viewControllers.first as? AuthViewController
            authViewController?.delegate = self
        }
    }

    func presentMainScreen() {
        performSegue(withIdentifier: "showMainScreen", sender: self)
    }
}

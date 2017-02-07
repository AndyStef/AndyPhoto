//
//  AuthViewController.swift
//  AndyPhoto
//
//  Created by Andy Stef on 2/7/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {

    fileprivate var webView: WKWebView?
    weak var delegate: StartViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: view.bounds)
        webView?.navigationDelegate = self
        view.addSubview(webView ?? WKWebView())
        guard let url = AuthManager.sharedInstance.authURL() else { return }
        let request = URLRequest(url: url)
        webView?.load(request)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let urlString = webView.url?.absoluteString {
            if urlString == AuthManager.sharedInstance.authURL()?.absoluteString {
                return
            }

            let code = NSString(string: urlString)
            let actualCode = code.lastPathComponent

            guard let tokenAccessUrl = AuthManager.sharedInstance.accessTokenUrl(code: actualCode) else { return }
            AuthManager.sharedInstance.retrieveAccessTokenFrom(url: tokenAccessUrl, completionHandler: {
                self.dismiss(animated: true, completion: { [weak self] in
                    self?.delegate?.presentMainScreen()
                })
            })
        }
    }
}

//MARK: - Actions
extension AuthViewController {
    @IBAction private func backAction(_ sender: Any) {
        if webView?.canGoBack ?? false {
            webView?.goBack()
        }
    }

    @IBAction private func homeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

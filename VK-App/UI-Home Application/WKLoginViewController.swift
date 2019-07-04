//
//  WKLoginViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 04/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import WebKit

class WKLoginViewController: UIViewController {

    @IBOutlet weak var WKLoginView: WKWebView!{
        didSet{
            WKLoginView.navigationDelegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Session.instance.client_id),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        WKLoginView.load(request)
        
    }
}


extension WKLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        Session.instance.app_token = params["access_token"]
        
        print(Session.instance.app_token)
        if Session.instance.app_token != nil {
            performSegue(withIdentifier: "signIn", sender: nil)
        }
        
        
        decisionHandler(.cancel)
    }
}

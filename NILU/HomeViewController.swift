//
//  HomeViewController.swift
//  NILU
//
//  Created by ogawa_kousuke on 2017/08/30.
//  Copyright © 2017年 Kosuke Ogawa All rights reserved.
//

import UIKit
import WebKit

class HomeViewController: WebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.view.backgroundColor = UIColor.white

        self.webView?.load(URLRequest(url: URL(string: Constants.homeUrl)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webView, didFinish: navigation)

        UIApplication.shared.isNetworkActivityIndicatorVisible = false

        // Hide ranking & news
        self.webView.evaluateJavaScript("document.getElementsByClassName('col-md-4')[0].style.display = 'none';", completionHandler: nil)
    }
}

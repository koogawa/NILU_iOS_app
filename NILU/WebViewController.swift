//
//  WebViewController.swift
//  NILU
//
//  Created by ogawa_kousuke on 2017/08/30.
//  Copyright © 2017年 Kosuke Ogawa All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    public var webView: WKWebView!
    private var refreshControl: UIRefreshControl!
    public var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let rect : CGRect = UIScreen.main.bounds
        self.webView = WKWebView(frame: CGRect(x: 0, y: 64, width: rect.size.width, height: rect.size.height - 64))
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)

        if let url = self.url {
            self.webView?.load(URLRequest(url: url))
        }

        self.addRefreshControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func pullToRefresh() {
        self.refreshControl.endRefreshing()
        self.webView.reload()
    }

    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for:.valueChanged)
        self.webView.scrollView.addSubview(refreshControl)
    }
}

// MARK: - WKWebView delegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.navigationItem.title = self.webView.title
        self.webView.evaluateJavaScript("document.getElementById('navbar').className = 'd-none';",
                                        completionHandler: nil)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard navigationAction.navigationType == .linkActivated else {
            decisionHandler(.allow)
            return
        }

        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }

        // for target="_blank"
        if navigationAction.targetFrame == nil {
            self.webView?.load(navigationAction.request)
            decisionHandler(.cancel)
            return
        }

        if (url.absoluteString.hasPrefix(Constants.niluPrefix)) {
            let viewController = WebViewController()
            viewController.url = url
            self.show(viewController, sender: nil)
        } else {
            // External site
            UIApplication.shared.openURL(url)
        }

        decisionHandler(.cancel)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

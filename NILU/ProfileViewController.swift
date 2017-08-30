//
//  ProfileViewController.swift
//  NILU
//
//  Created by ogawa_kousuke on 2017/08/30.
//  Copyright © 2017年 Kosuke Ogawa All rights reserved.
//

import UIKit

class ProfileViewController: WebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.view.backgroundColor = UIColor.white

        self.webView?.load(URLRequest(url: URL(string: Constants.profileUrl)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

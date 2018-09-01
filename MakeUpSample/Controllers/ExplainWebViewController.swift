//
//  ExplainWebViewController.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/09/01.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit
import WebKit

class ExplainWebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        
        let request = NSURLRequest(url: URL(string: self.url)!)
        webView.load(request as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }

 

}

//
//  WebViewController.swift
//  WikipediaSearch
//
//  Created by Mohan on 21/07/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {
    let cache = URLCache()
    var selectedPageId : String?
    var pagetitle: String?
    var urlRequestCache : URLRequest?
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
//    var store : WKWebsiteDataRecord = WKWebsiteDataRecord()
    
    @IBOutlet weak var WebView: WKWebView!
    @IBOutlet weak var WebpageTitle: UINavigationItem!
    @IBAction func BackButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var BackButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
//        store?.dataTypes = WKWebsiteDataTypeOfflineWebApplicationCache
        
        self.WebView.navigationDelegate = self

        self.WebpageTitle.title = pagetitle
        
        if let _ = selectedPageId {
           var url = URL(string: "https://en.m.wikipedia.org/?curid=\(selectedPageId!)")!
            var urlRequestCache : URLRequest
            if ConnectionCheck.isConnectedToNetwork() {
                self.urlRequestCache=NSURLRequest(url : url, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: TimeInterval(10)) as URLRequest
      
            }
            else {
                self.urlRequestCache = NSURLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: TimeInterval(100)) as URLRequest
            }
        
            WebView.load(self.urlRequestCache!)

        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.loaderStart()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loaderStop()
        webView
        
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

//        cache.storeCachedResponse( CachedURLResponse(response: navigationResponse.response, data: Data()), for: self.urlRequestCache!)
    }

    
    func loaderStart()
    {
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        indicator.bounds = UIScreen.main.bounds
        UIApplication.shared.keyWindow!.addSubview(indicator)
        indicator.bringSubview(toFront: view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        indicator.startAnimating()
    }
    
    func loaderStop()
    {
        indicator.stopAnimating()
    }

}



//
//  IGLoginViewController.swift
//  usingInstagramAPI_SWIFT
//
//  Created by Thomas Neary on 4/26/16.
//  Copyright © 2016 OpCon Technologies, Inc. All rights reserved.
// 

import UIKit

class IGLoginViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var loginView: UIWebView!
    
    var appClientID: NSString = "YOUR CLIENT ID GOES HERE"
    var appRedirectURL: NSString = "YOUR APP REDIRECT URL GOES HERE"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self;

        // Do any additional setup after loading the view.
        
        //Manual Way...
        print("Going to Instaram API...")
        let stringURL: String = String(format: "https://api.instagram.com/oauth/authorize/?client_id=\(appClientID)&redirect_uri=\(appRedirectURL)&response_type=token")
        print(stringURL)
        let authURL: NSURL = NSURL(string: stringURL)!
        self.loginView.loadRequest(NSURLRequest(URL: authURL))
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
    //print("Webview did fail with error \(error)");
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
    print("Webview did start load")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
    print("Webview did finish load")
    }
    
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {

        print("Getting Token...")
        
        let clickedURL: NSURL = request.URL!
        let URLString: String = clickedURL.absoluteString
        var tmpArr: [AnyObject] = URLString.componentsSeparatedByString("=")
        let code: String = tmpArr[1] as! String
        NSLog("code: %@", code)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(code, forKey: "IGToken")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // Now... the tricky part of retiring the Web View....
        
        // When the IG login page loads it has &next, 
        // when IG login is checking loads a url that contains &redriect_uri
        // But when code is delivered it does not have any "&" characters in the url
        // So look for absence of & in the code and at that point close the web view
        let str  : NSString = code
        let path : NSString = str.stringByDeletingLastPathComponent
        let ext  : NSString = str.lastPathComponent
        print(path)
        print(ext)
        if ext.containsString("&") {
            print("Yes it contains '&'")
        }else{
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }

        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

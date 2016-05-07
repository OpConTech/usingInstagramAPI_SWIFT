//
//  FirstViewController.swift
//  usingInstagramAPI_SWIFT
//
//  Created by Thomas Neary on 4/26/16.
//  Copyright © 2016 OpCon Technologies, Inc. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBAction func unwindWithSelectedView(segue:UIStoryboardSegue) {}
    @IBOutlet weak var IGProfilePicture: UIImageView!
    @IBOutlet weak var IGFullName: UILabel!
    @IBOutlet weak var IGUsername: UILabel!
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        self.IGUsername.text = "Please"
        self.IGFullName.text = "Login to Instagram"
        self.IGProfilePicture.image = UIImage()
        self.getIGData()
        
    }
    
    
    func getIGData() {

        // See if a token was previously saved to NSUserDefaults on the device
        if let igToken: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("IGToken") {
            //print(igToken)
            //https://api.instagram.com/v1/users/self/?access_token=ACCESS-TOKEN
            let url = NSURL(string: "https://api.instagram.com/v1/users/self/?access_token=\(igToken)")
            print("IG API Path for API Request: \(url)")
            
            dataTask = defaultSession.dataTaskWithURL(url!) {
            data, response, error in
                
                dispatch_async(dispatch_get_main_queue()) {
                    if let error = error {
                        
                        print(error.localizedDescription)
                        
                    } else if let httpResponse = response as? NSHTTPURLResponse {
                        
                        print("IG API HTTP Status Code Is: \(httpResponse.statusCode)")

                        if httpResponse.statusCode == 200 {
                            
                            do {
                                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:AnyObject]
                                
                                //print(jsonResult)
                                //print(jsonResult["data"]!["profile_picture"])
                                //print(jsonResult["data"]!["username"])
                                //(jsonResult["data"]!["full_name"])
                                
                                // Parse the JSON Result and post to view
                                if let result = jsonResult as? [String: AnyObject] {
                                    if let resultUsername = result["data"]!["username"] as? String
                                    {

                                        print("IG API username: \(resultUsername)")
                                        self.IGUsername.text = resultUsername as String
                                    }
                                    if let resultFullName = result["data"]!["full_name"] as? String
                                    {
                                        print("IG API full_name: \(resultFullName)")
                                        self.IGFullName.text = resultFullName as String
                                    }
                                    if let urlString = result["data"]!["profile_picture"] as? String
                                    {
                                        print("IG API profile_picture: \(urlString)")
                                        let urlStringHttps =  urlString.stringByReplacingOccurrencesOfString("http", withString: "https")
                                        if let url = NSURL(string: urlStringHttps) {
                                            if let data = NSData(contentsOfURL: url) {
                                                self.IGProfilePicture.image = UIImage(data:data)
                                            }
                                        }
                                    }
                                }
                                
                            } catch let error as NSError {
                                print("json error: \(error.localizedDescription)")
                            }

                        }// end if http response = 200 (good)
                        
                    }
                    
                }// end dispatch on main thread
                    
            }// end network call

            
            dataTask?.resume()
                
                
            } else {
                print("Token not Found on Device")
        }
        
    }
    
    
    @IBAction func logoutTapped(sender: AnyObject) {
        
        // clear the ?? not sure what these next two lines clear...
        let appDomain = NSBundle.mainBundle().bundleIdentifier!
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)

        // clear the keys
        print(Array(NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys).count)
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "justAnotherKey1")
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "justAnotherKey2")
        print(Array(NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys).count)
        for key in Array(NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys) {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }
        
        // clear the web view cookies
        print(Array(NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys).count)
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
        
        // synch
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // let the person know they are logged out of IG
        let alert = UIAlertController(title: "Logged Out!", message: "Your Instagram account has been disconnected from this app.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        // update the data on the view
        self.IGUsername.text = "Please"
        self.IGFullName.text = "Login to Instagram"
        self.IGProfilePicture.image = UIImage()
        self.getIGData()

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
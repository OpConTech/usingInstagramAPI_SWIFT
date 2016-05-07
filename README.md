# usingInstagramAPI (Swift)

This is the iOS application to
[*Learn and test the inegration of Instagram into your app*] (https://github.com/OpConTech/usingInstagramAPI_SWIFT)

by [*Tom Neary*]  
[![Contact me on Codementor](https://cdn.codementor.io/badges/contact_me_github.svg)](https://www.codementor.io/tomneary?utm_source=github&utm_medium=button&utm_term=tomneary&utm_campaign=github)


![usingInstagramAPI_SWIFT](https://www.knowledgekeeper.com/assets/githubProjects/usingInstagramAPI_01.png)  
![usingInstagramAPI_SWIFT](https://www.knowledgekeeper.com/assets/githubProjects/usingInstagramAPI_03.png)


# Description

Having Issues with the Instagram API and your App? 

Are you not able to get the Instgram API to work with your App?

Do you need something where you can just enter your IG Client ID and Redirect UTL and see it work?

# Usage

### Enter your IG Developer Crentials
Add your IG Developer Credentials in the FirstViewController:  
    var appClientID: NSString = "YOUR CLIENT ID GOES HERE"  
    var appRedirectURL: NSString = "YOUR APP REDIRECT URL GOES HERE" 

### Connect to Instagram
Click the connect button and a web view will open to the IG Login. When you login your IG Credentials will be passed to IG. If the account you are logging into is Sandboxed in your IG Developer account a token will be returned and the app will be connected to the IG API and will return the profile picture, username and full name of the connected account.

![usingInstagramAPI_SWIFT](https://www.knowledgekeeper.com/assets/githubProjects/usingInstagramAPI_02.png)


### Logout
Click logut to disconnect the app from the IG API.

![usingInstagramAPI_SWIFT](https://www.knowledgekeeper.com/assets/githubProjects/usingInstagramAPI_04.png)



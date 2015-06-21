//
//  BeforeSignInUpVC + Google+.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 21/06/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

//G+
import AddressBook
import MediaPlayer
import AssetsLibrary
import CoreLocation
import CoreMotion

extension BeforeSignInUpVC{
    
    func viewDidLoadGoogle(){
        self.signIn = GPPSignIn.sharedInstance()
        
        self.googleButton.style = kGPPSignInButtonStyleWide
        self.googleButton.colorScheme = kGPPSignInButtonColorSchemeDark
        
        self.signIn.shouldFetchGooglePlusUser = true
        self.signIn.shouldFetchGoogleUserID = true
        self.signIn.shouldFetchGoogleUserEmail = true
        
        self.signIn.clientID = clientId
        self.signIn.scopes = [kGTLAuthScopePlusLogin]
        self.signIn.delegate = self
        
    }
    
    @IBAction func signInOut(sender: GPPSignInButton) {
        if self.signIn.hasAuthInKeychain() {
            self.signIn.signOut()
        }else{
            self.signIn.authenticate()
        }
    
    }
    
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        if ((error) != nil)
        {
            print(error)
            // Process error
        }else{
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
            let userName = signIn?.googlePlusUser.displayName
            let userEmail = auth.userEmail
            let userId = self.signIn.userID
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func didDisconnectWithError(error: NSError!) {
        println("connect fail")
    }

}
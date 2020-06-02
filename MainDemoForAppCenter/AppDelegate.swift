//
//  AppDelegate.swift
//  MainDemoForAppCenter
//
//  Created by Shaybaz Sayyed on 2020-06-02.
//  Copyright © 2020 Shaybaz Sayyed. All rights reserved.
//

import UIKit
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import AppCenterDistribute

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MSDistributeDelegate{

var window: UIWindow? 
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        MSAppCenter.start("81676a51-ff9c-42b6-b40b-2c8251a2a137", withServices:[
          MSCrashes.self
        ])
        MSAppCenter.start("81676a51-ff9c-42b6-b40b-2c8251a2a137", withServices: [MSDistribute.self])
        MSDistribute.setEnabled(true)
        MSDistribute.checkForUpdate()
        MSDistribute.setDelegate(self);
        MSDistribute.notify(MSUpdateAction.update);
        MSDistribute.notify(MSUpdateAction.postpone);

        return true
    }
    func distribute(_ distribute: MSDistribute!, releaseAvailableWith details: MSReleaseDetails!) -> Bool {

      // Your code to present your UI to the user, e.g. an UIAlertController.
      let alertController = UIAlertController(title: "Update available.",
                                            message: "Do you want to update?",
                                     preferredStyle:.alert)

      alertController.addAction(UIAlertAction(title: "Update", style: .cancel) {_ in
        MSDistribute.notify(.update)
      })

      alertController.addAction(UIAlertAction(title: "Postpone", style: .default) {_ in
        MSDistribute.notify(.postpone)
      })

      // Show the alert controller.
        self.window?.rootViewController?.present(alertController, animated: true)
      return true;
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


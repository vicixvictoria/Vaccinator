//
//  AppDelegate.swift
//  Vaccinator
//
//  Created by Maximilian Reisecker on 21.04.21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
        
        //var endpointProvider = EndpointProvider()

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            /*  _ = self.window!.rootViewController as! UISplitViewController
            let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.endIndex-1] as! UINavigationController
            splitViewController.delegate = navigationController.topViewController as! DetailViewController*/
            
            // SMART tint color
            window?.tintColor = UIColor(red:0.41, green:0.14, blue:0.44, alpha:1.0)
            
            // configured endpoints
            //endpointProvider.endpoints = configuredEndpoints()
            
            /*let masterNavi = splitViewController.viewControllers[splitViewController.viewControllers.startIndex] as! UINavigationController
            let master = masterNavi.topViewController as! MasterViewController
            master.endpointProvider = endpointProvider*/
            
            return true
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
        
        /*func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            guard let smart = endpointProvider.activeEndpoint?.client else {
                window?.rootViewController?.show(AppError.noActiveEndpoint as! UIViewController, sender: "Not Set Up")
                return false
            }
            if smart.awaitingAuthCallback {
                return smart.didRedirect(to: url)
            }
            return false
        }*/

    }





enum AppError: Error, CustomStringConvertible {
    case noEndpointProvider
    case noActiveEndpoint
    case noPatientSelected
    
    var description: String {
        switch self {
        case .noEndpointProvider:
            return "No endpoint provider is present, cannot continue"
        case .noActiveEndpoint:
            return "No endpoint (server) has been selected yet, please do that first"
        case .noPatientSelected:
            return "No patient has been selected, please do that first"
        }
    }
}


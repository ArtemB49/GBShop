//
//  AppDelegate.swift
//  av.belyaev
//
//  Created by Артем Б on 03.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let requestFactory = RequestFactory()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let auth: AuthRequestFactory = requestFactory.makeAuthRequestFactory()
        auth.login(
        userName: "Somebody",
        password: "mypassword"){ response in
            switch response.result{
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
        auth.registration(
            userInfo: UserInfo(
                id: 322,
                userName: "bob",
                password: "boec",
                email: "bob@ex.ru",
                gender: "m",
                creditCard: "4925_2555_7845_2500",
                bio: "I am hungry"
                )
            ){ response in
                switch response.result {
                case .success(let checkIn):
                    print(checkIn)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
        auth.logout(userID: 322) { response in
            switch response.result{
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let modification: UserDataRequestFactory = requestFactory.makeModificationRequestFactory()
        modification.editUserData(
            userInfo: UserInfo(
                id: 322,
                userName: "bob",
                password: "4355",
                email: "bob2@ya.ru",
                gender: "f",
                creditCard: "4276_8001_7589_4877",
                bio: "Like a boss Smoke weed everyday"
                )
            ){ response in
                switch response.result {
                case .success(let modify):
                    print(modify)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }       
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


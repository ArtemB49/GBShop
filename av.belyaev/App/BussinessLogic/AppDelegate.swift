//
//  AppDelegate.swift
//  av.belyaev
//
//  Created by Артем Б on 03.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Fabric.with([Crashlytics.self])

       return true
    }
}

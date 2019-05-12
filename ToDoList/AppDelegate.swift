//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Thomas LeBlanc on 5/7/19.
//  Copyright © 2019 AnyoneCanInvest. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        print(Realm.Configuration.defaultConfiguration.fileURL)

        do {
            _ = try Realm()
        } catch {
            print("Error initializing new Realm \(error)")
        }

        return true
    }

}


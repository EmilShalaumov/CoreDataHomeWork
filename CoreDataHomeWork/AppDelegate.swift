//
//  AppDelegate.swift
//  CoreDataHomeWork
//
//  Created by Эмиль Шалаумов on 24.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let service = NetworkService(session: SessionFactory().createDefaultSession())
        let interactor = Interactor(networkService: service)
        
        let viewController = UINavigationController(rootViewController: ViewController(interactor: interactor))
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        
        return true
    }
    
}


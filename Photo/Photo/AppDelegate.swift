//
//  AppDelegate.swift
//  Photo
//
//  Created by TANYA GYGI on 11/30/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)

        let dataProvider = AlbumsResult()
        let viewModel = AlbumViewModel(dataProvider: dataProvider)

        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = AlbumVC(viewModel: viewModel)
        return true
    }

}


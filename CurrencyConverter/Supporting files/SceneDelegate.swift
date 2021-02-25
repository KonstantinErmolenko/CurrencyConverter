//
//  SceneDelegate.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.accessibilityIdentifier = "mainWindow"
        let navVC = UINavigationController(rootViewController: ConverterViewController())
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

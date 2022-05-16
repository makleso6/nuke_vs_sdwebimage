//
//  AppDelegate.swift
//  NukeApplication
//
//  Created by Maksim Kolesnik on 13.05.2022.
//

import UIKit
//import Nuke

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let big = Bundle.main.url(forResource: "big", withExtension: "webp")!
//        do {
//            let imageData = try Data(contentsOf: big)
//            autoreleasepool(invoking: {
////                let img = try? WebPDecoder().decode(toUImage: imageData, options: WebPDecoderOptions())
//                let img = WebDecoder().decode2(data: imageData)
//                print(img)
//            })
//        } catch {
//
//        }
        // Override point for customization after application launch.
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController(nibName: nil, bundle: nil)
        window?.makeKeyAndVisible()
//        ImageCache.shared.removeAll()
//        Nuke.DataLoader.sharedUrlCache.removeAllCachedResponses()

//        WebPImageDecoder.enable(auto: BasicWebPDecoder())

        return true
    }

}


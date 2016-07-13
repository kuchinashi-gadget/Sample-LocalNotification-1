//
//  AppDelegate.swift
//  Sample_LocalNotification_1
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        //アプリが復帰したらバッジを0にする
        application.applicationIconBadgeNumber = 0
        
        if #available(iOS 8.0, *) {
            // iOS8以上
            let notiSettings = UIUserNotificationSettings(forTypes:[.Alert,.Sound,.Badge], categories:nil)
            application.registerUserNotificationSettings(notiSettings)
            application.registerForRemoteNotifications()
            
        } else{
            // iOS7以前
            application.registerForRemoteNotificationTypes( [.Alert,.Sound,.Badge] )
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //古い通知があれば削除する
        application.cancelAllLocalNotifications()
        
        
        let mln = Mkae_Local_Notification()
        let notification = mln.make_localnotification()
        
        //通知をスケジューリング
        application.scheduleLocalNotification(notification)
        
        
        

    }
    

    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        //アプリがactive時に通知を発生させた時にも呼ばれる
        if application.applicationState != .Active{
            //バッジを０にする
            application.applicationIconBadgeNumber = 0
            //通知領域から削除する
            application.cancelLocalNotification(notification)
        }else{
            //active時に通知が来たときはそのままバッジを0に戻す
            if application.applicationIconBadgeNumber != 0{
                application.applicationIconBadgeNumber = 0
                application.cancelLocalNotification(notification)
            }
        }
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


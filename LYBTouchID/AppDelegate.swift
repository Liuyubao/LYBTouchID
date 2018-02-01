//
//  AppDelegate.swift
//  LYBTouchID
//
//  Created by 柳玉豹 on 2018/1/30.
//  Copyright © 2018年 xinghaiwulian. All rights reserved.
//

import UIKit
import LocalAuthentication

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        UserDefaults.standard.set(timeStamp, forKey: "currentTime")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("进入前台")
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let currentTime = UserDefaults.standard.value(forKey: "currentTime")
        if (timeStamp - (currentTime as! Int)) > 5
        {
            let vc = self.window?.rootViewController as! LYBMainVC
            vc.gestureView.isHidden = false
            vc.gestureView.isFirst = false
            vc.gestureView.messagerLabel.text = "确认手势密码"
            
            //指纹解锁
            let authenticationContext = LAContext()
            var error: NSError?
            let fingerPrint = UserDefaults.standard.value(forKey: "fingerPrint")
            if ((fingerPrint != nil) && fingerPrint as! Bool)
            {
                //步骤1：检查Touch ID是否可用
                let isTouchIdAvailable = authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error)
                //真机上可以使用,模拟器上不可使用
                if isTouchIdAvailable
                {
                    print("恭喜，Touch ID可以使用！")
                    //回主线程去隐藏View,若是在子线程中隐藏则延迟太厉害
                    //步骤2：获取指纹验证结果
                    authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "需要验证您的指纹来确认您的身份信息", reply:
                        {
                            (success, error) -> Void in
                            if success
                            {
                                print("恭喜，您通过了Touch ID指纹验证！")
                                OperationQueue.main.addOperation
                                    {
                                        vc.gestureView.isHidden = true
                                }
                                return
                            }
                            else
                            {
                                print("抱歉，您未能通过Touch ID指纹验证！\n\(String(describing: error))")
                            }
                    })
                }
                else
                {
                    print("呵呵呵呵呵呵指纹不能用")
                }
                
                
                
            }
            else
            {
                print("不用指纹解锁")
            }
            
            
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//
//  AppDelegate.swift
//  FourcutDiary
//
//  Created by 강윤서 on 8/19/24.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import KakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		KakaoSDK.initSDK(appKey: Config.kakaoAppKey)
		setUserNotification(application)
		setFirebaseMessaging()
		
		return true
	}
	
	// MARK: UISceneSession Lifecycle
	
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}
	
	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}

// MARK: - Custom Setting

extension AppDelegate: UNUserNotificationCenterDelegate {
	/// 권한 요청 -> 추후 온보딩으로 이동
	private func setUserNotification(_ application: UIApplication) {
		UNUserNotificationCenter.current().delegate = self
		
		let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
		UNUserNotificationCenter.current().requestAuthorization(
			options: authOptions,
			completionHandler: { _, _ in }
		)
		
		application.registerForRemoteNotifications()
	}
	
	private func setFirebaseMessaging() {
		FirebaseApp.configure()
		Messaging.messaging().delegate = self
		Messaging.messaging().isAutoInitEnabled = true
	}
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
		print("Firebase registration token: \(String(describing: fcmToken))")
		
		Messaging.messaging().token { token, error in
			if let error = error {
				print("Error fetching FCM registration token: \(error)")
			} else if let token = token {
				// TODO: - UserDefault에 FCM 토큰 저장
				// UserDefaultsManager.fcmToken = token
				print("FCM registration token: \(token)")
			}
		}
	}
}

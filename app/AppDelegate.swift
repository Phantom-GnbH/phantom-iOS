//

import UIKit
import CoreSpotlight
import ProgressHUD
import PasscodeKit
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var tabBarController: UITabBarController!

	var chatsView: ChatsView!
	var peopleView: PeopleView!
	var groupsView: GroupsView!
	var settingsView: SettingsView!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {


		//---------------------------------------------------------------------------------------------------------------------------------------
		//.devGraphQLite initialization
		//---------------------------------------------------------------------------------------------------------------------------------------
		GraphQLite.setup()

		//---------------------------------------------------------------------------------------------------------------------------------------
		//.devPush notification initialization
		//---------------------------------------------------------------------------------------------------------------------------------------
		let center = UNUserNotificationCenter.current()
		center.requestAuthorization(options: [.sound, .alert, .badge], completionHandler: { granted, error in
			if (error == nil) {
				DispatchQueue.main.async {
					UIApplication.shared.registerForRemoteNotifications()
				}
			}
		})

		//---------------------------------------------------------------------------------------------------------------------------------------
		//.devManager initialization
		//---------------------------------------------------------------------------------------------------------------------------------------
		Location.setup()

		//---------------------------------------------------------------------------------------------------------------------------------------
		//.devMediaUploader initialization
		//---------------------------------------------------------------------------------------------------------------------------------------
		MediaUploader.setup()

		//---------------------------------------------------------------------------------------------------------------------------------------
		//.devUI initialization
		//---------------------------------------------------------------------------------------------------------------------------------------
		window = UIWindow(frame: UIScreen.main.bounds)

		chatsView = ChatsView(nibName: "ChatsView", bundle: nil)
		peopleView = PeopleView(nibName: "PeopleView", bundle: nil)
		groupsView = GroupsView(nibName: "GroupsView", bundle: nil)
		settingsView = SettingsView(nibName: "SettingsView", bundle: nil)

		let navController1 = NavigationController(rootViewController: chatsView)
		let navController2 = NavigationController(rootViewController: peopleView)
		let navController3 = NavigationController(rootViewController: groupsView)
		let navController4 = NavigationController(rootViewController: settingsView)

		tabBarController = UITabBarController()
		tabBarController.viewControllers = [navController1, navController2, navController3, navController4]
		tabBarController.tabBar.isTranslucent = false
		tabBarController.selectedIndex = App.DefaultTab

		if #available(iOS 15.0, *) {
			let appearance = UITabBarAppearance()
			appearance.configureWithOpaqueBackground()
			tabBarController.tabBar.standardAppearance = appearance
			tabBarController.tabBar.scrollEdgeAppearance = appearance
		}

		window?.rootViewController = tabBarController
		window?.makeKeyAndVisible()

		_ = chatsView.view
		_ = peopleView.view
		_ = groupsView.view
		_ = settingsView.view

		//---------------------------------------------------------------------------------------------------------------------------------------
		//.devUITableView padding
		//---------------------------------------------------------------------------------------------------------------------------------------
		if #available(iOS 15.0, *) {
			UITableView.appearance().sectionHeaderTopPadding = 0
		}

		//---------------------------------------------------------------------------------------------------------------------------------------
		//.devPasscodeKit initialization
		//---------------------------------------------------------------------------------------------------------------------------------------
		PasscodeKit.delegate = self
		PasscodeKit.start()

		//---------------------------------------------------------------------------------------------------------------------------------------
		//.devProgressHUD initialization
		//---------------------------------------------------------------------------------------------------------------------------------------
		ProgressHUD.colorProgress = UIColor.systemBlue
		ProgressHUD.colorAnimation = UIColor.systemBlue

		return true
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func applicationWillResignActive(_ application: UIApplication) {

		NotificationCenter.post(Notifications.AppWillResign)
		DBUsers.updateTerminate()
		Location.stop()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func applicationDidEnterBackground(_ application: UIApplication) {

	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func applicationWillEnterForeground(_ application: UIApplication) {

	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func applicationDidBecomeActive(_ application: UIApplication) {

		Location.start()
		Media.cleanupExpired()

		DispatchQueue.main.async(after: 0.5) {
			DBUsers.updateActive()
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func applicationWillTerminate(_ application: UIApplication) {

	}

}

//.devMARK: - Push notification methods
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension AppDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

		GQLPush.token(deviceToken)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {

		if (application.applicationState != .active) { return }

		//if let custom = userInfo["custom"] as? [String: Any] {
		//	if let dict = custom["a"] as? [String: Any] {
		//		if let chatId = dict["chatId"] as? String {
		//			print(chatId)
		//		}
		//	}
		//}

		//if let aps = userInfo["aps"] as? [String: Any] {
		//	if let alert = aps["alert"] as? String {
		//		print(alert)
		//	}
		//}
	}
}

//.devMARK: - Core Spotlight methods
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension AppDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

		if (userActivity.activityType == CSSearchableItemActionType) {
			if let userId = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String {
				if (GQLAuth.userId() != "") {
					peopleView.actionUser(userId: userId)
					return true
				}
			}
		}
		return false
	}
}

//.devMARK: - Home screen dynamic quick action methods
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension AppDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {

		if (GQLAuth.userId() != "") {
			if (shortcutItem.type == "newchat") {
				chatsView.actionNewChat()
			}
			if (shortcutItem.type == "newgroup") {
				groupsView.actionNewGroup()
			}
			if (shortcutItem.type == "recentuser") {
				if let userInfo = shortcutItem.userInfo as? [String: String] {
					if let userId = userInfo["userId"] {
						chatsView.actionRecentUser(userId: userId)
					}
				}
			}
		}

		if (shortcutItem.type == "shareapp") {
			if let topViewController = topViewController() {
				let activityView = UIActivityViewController(activityItems: [App.TextShareApp], applicationActivities: nil)
				topViewController.present(activityView, animated: true)
			}
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func topViewController() -> UIViewController? {

		let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
		var viewController = keyWindow?.rootViewController

		while (viewController?.presentedViewController != nil) {
			viewController = viewController?.presentedViewController
		}
		return viewController
	}
}

//.devMARK: - PasscodeKitDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension AppDelegate: PasscodeKitDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func passcodeCheckedButDisabled() {

		NotificationCenter.post(Notifications.AppStarted)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func passcodeEnteredSuccessfully() {

		NotificationCenter.post(Notifications.AppStarted)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func passcodeMaximumFailedAttempts() {

		ProgressHUD.colorAnimation = UIColor.systemRed
		ProgressHUD.show(nil, interaction: false)

		Users.prepareLogout()
		DispatchQueue.main.async(after: 1.0) {
			Users.performLogout()
			DispatchQueue.main.async(after: 0.5) {
				exit(0)
			}
		}
	}
}

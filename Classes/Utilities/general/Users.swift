//

import UIKit
import CoreSpotlight
import ProgressHUD
import PasscodeKit
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class Users: NSObject {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func login(_ viewController: UIViewController) {

		let welcomeView = WelcomeView()
		welcomeView.isModalInPresentation = true
		welcomeView.modalPresentationStyle = .fullScreen
		viewController.present(welcomeView, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func onboard(_ viewController: UIViewController) {

		let editProfileView = EditProfileView(onboard: true)
		let navController = NavigationController(rootViewController: editProfileView)
		navController.isModalInPresentation = true
		navController.modalPresentationStyle = .fullScreen
		viewController.present(navController, animated: true)
	}

	//.devMARK: -
	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func loggedIn() {

		Shortcut.create()

		if (DBUsers.fullname() != "") {
			ProgressHUD.showSucceed("Welcome back!")
		} else {
			ProgressHUD.showSucceed("Welcome!")
		}

		NotificationCenter.post(Notifications.UserLoggedIn)

		DispatchQueue.main.async(after: 0.5) {
			DBUsers.updateActive()
		}

		GQLPush.register(GQLAuth.userId())
	}

	//.devMARK: -
	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func prepareLogout() {

		GQLPush.unregister()

		DBUsers.updateTerminate()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func performLogout() {

		NotificationCenter.post(Notifications.UserLoggedOut)

		Media.cleanupManual(logout: true)

		PasscodeKit.remove()

		gqldb.cleanupDatabase()
		gqlsync.cleanup()

		LastUpdated.cleanup()

		CSSearchableIndex.default().deleteAllSearchableItems()

		Shortcut.cleanup()

		GQLAuth.signOut()
	}
}

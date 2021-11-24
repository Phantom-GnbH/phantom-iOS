//

import UIKit
import ProgressHUD
import PasscodeKit
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class SettingsView: UITableViewController {

	@IBOutlet private var viewHeader: UIView!
	@IBOutlet private var imageUser: UIImageView!
	@IBOutlet private var labelInitials: UILabel!
	@IBOutlet private var labelName: UILabel!
	@IBOutlet private var cellProfile: UITableViewCell!
	@IBOutlet private var cellPassword: UITableViewCell!
	@IBOutlet private var cellPasscode: UITableViewCell!
	@IBOutlet private var cellStatus: UITableViewCell!
	@IBOutlet private var cellBlocked: UITableViewCell!
	@IBOutlet private var cellArchive: UITableViewCell!
	@IBOutlet private var cellCache: UITableViewCell!
	@IBOutlet private var cellMedia: UITableViewCell!
	@IBOutlet private var cellPrivacy: UITableViewCell!
	@IBOutlet private var cellTerms: UITableViewCell!
	@IBOutlet private var cellLogout: UITableViewCell!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

		tabBarItem.image = UIImage(systemName: "gear")
		tabBarItem.title = "Settings"

		NotificationCenter.addObserver(self, selector: #selector(loadUser), text: Notifications.UserLoggedIn)
		NotificationCenter.addObserver(self, selector: #selector(actionCleanup), text: Notifications.UserLoggedOut)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	required init?(coder: NSCoder) {

		super.init(coder: coder)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Settings"

		navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)

		tableView.tableHeaderView = viewHeader
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewWillAppear(_ animated: Bool) {

		super.viewWillAppear(animated)

		if (GQLAuth.userId() != "") {
			loadUser()
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidAppear(_ animated: Bool) {

		super.viewDidAppear(animated)

		if (GQLAuth.userId() != "") {
			if (DBUsers.fullname() != "") {

			} else { Users.onboard(self) }
		} else { Users.login(self) }
	}

	//.devMARK: - Database methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func loadUser() {

		guard let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId()) else { return }

		labelInitials.text = dbuser.initials()
		MediaDownload.user(dbuser.objectId, dbuser.pictureAt) { image, error in
			if (error == nil) {
				self.imageUser.image = image?.square(to: 70)
				self.labelInitials.text = nil
			}
		}

		labelName.text = dbuser.fullname

		cellPasscode.detailTextLabel?.text = PasscodeKit.enabled() ? "On" : "Off"

		cellStatus.textLabel?.text = dbuser.status

		tableView.reloadData()
	}

	//.devMARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionProfile() {

		let editProfileView = EditProfileView(onboard: false)
		let navController = NavigationController(rootViewController: editProfileView)
		navController.isModalInPresentation = true
		navController.modalPresentationStyle = .fullScreen
		present(navController, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionPassword() {

		let passwordView = PasswordView()
		let navController = NavigationController(rootViewController: passwordView)
		navController.isModalInPresentation = true
		navController.modalPresentationStyle = .fullScreen
		present(navController, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionPasscode() {

		let passcodeView = PasscodeView()
		passcodeView.hidesBottomBarWhenPushed = true
		navigationController?.pushViewController(passcodeView, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionStatus() {

		let statusView = StatusView()
		statusView.hidesBottomBarWhenPushed = true
		navigationController?.pushViewController(statusView, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionBlocked() {

		let blockedView = BlockedView()
		blockedView.hidesBottomBarWhenPushed = true
		navigationController?.pushViewController(blockedView, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionArchive() {

		let archivedView = ArchivedView()
		archivedView.hidesBottomBarWhenPushed = true
		navigationController?.pushViewController(archivedView, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionCache() {

		let cacheView = CacheView()
		cacheView.hidesBottomBarWhenPushed = true
		navigationController?.pushViewController(cacheView, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionMedia() {

		let mediaView = MediaView()
		mediaView.hidesBottomBarWhenPushed = true
		navigationController?.pushViewController(mediaView, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionPrivacy() {

		let privacyView = PrivacyView()
		privacyView.hidesBottomBarWhenPushed = true
		navigationController?.pushViewController(privacyView, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionTerms() {

		let termsView = TermsView()
		termsView.hidesBottomBarWhenPushed = true
		navigationController?.pushViewController(termsView, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionLogout() {

		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

		alert.addAction(UIAlertAction(title: "Log out", style: .destructive) { action in
			self.actionLogoutUser()
		})
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

		present(alert, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionLogoutUser() {

		ProgressHUD.show(nil, interaction: false)
		Users.prepareLogout()
		DispatchQueue.main.async(after: 1.0) {
			Users.performLogout()
			ProgressHUD.dismiss()
			self.tabBarController?.selectedIndex = App.DefaultTab
		}
	}

	//.devMARK: - Cleanup methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionCleanup() {

		imageUser.image = nil
		labelName.text = nil
	}

	//.devMARK: - Table view data source
	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func numberOfSections(in tableView: UITableView) -> Int {

		return 5
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if (section == 0) { return 3 }
		if (section == 1) { return 1 }
		if (section == 2) { return 4 }
		if (section == 3) { return 2 }
		if (section == 4) { return 1 }

		return 0
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

		if (section == 1) { return "Status" }

		return nil
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		if (indexPath.section == 0) && (indexPath.row == 0) { return cellProfile	}
		if (indexPath.section == 0) && (indexPath.row == 1) { return cellPassword	}
		if (indexPath.section == 0) && (indexPath.row == 2) { return cellPasscode	}
		if (indexPath.section == 1) && (indexPath.row == 0) { return cellStatus		}
		if (indexPath.section == 2) && (indexPath.row == 0) { return cellBlocked	}
		if (indexPath.section == 2) && (indexPath.row == 1) { return cellArchive	}
		if (indexPath.section == 2) && (indexPath.row == 2) { return cellCache		}
		if (indexPath.section == 2) && (indexPath.row == 3) { return cellMedia		}
		if (indexPath.section == 3) && (indexPath.row == 0) { return cellPrivacy	}
		if (indexPath.section == 3) && (indexPath.row == 1) { return cellTerms		}
		if (indexPath.section == 4) && (indexPath.row == 0) { return cellLogout		}

		return UITableViewCell()
	}

	//.devMARK: - Table view delegate
	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)

		if (indexPath.section == 0) && (indexPath.row == 0) { actionProfile()		}
		if (indexPath.section == 0) && (indexPath.row == 1) { actionPassword()		}
		if (indexPath.section == 0) && (indexPath.row == 2) { actionPasscode()		}
		if (indexPath.section == 1) && (indexPath.row == 0) { actionStatus()		}
		if (indexPath.section == 2) && (indexPath.row == 0) { actionBlocked()		}
		if (indexPath.section == 2) && (indexPath.row == 1) { actionArchive()		}
		if (indexPath.section == 2) && (indexPath.row == 2) { actionCache()			}
		if (indexPath.section == 2) && (indexPath.row == 3) { actionMedia()			}
		if (indexPath.section == 3) && (indexPath.row == 0) { actionPrivacy()		}
		if (indexPath.section == 3) && (indexPath.row == 1) { actionTerms()			}
		if (indexPath.section == 4) && (indexPath.row == 0) { actionLogout()		}
	}
}

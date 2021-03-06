//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class StatusView: UIViewController {

	@IBOutlet private var tableView: UITableView!
	@IBOutlet private var cellStatus: UITableViewCell!
	@IBOutlet private var cellClear: UITableViewCell!

	private var statuses: [String] = []

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Status"

		loadStatuses()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewWillAppear(_ animated: Bool) {

		super.viewWillAppear(animated)

		cellStatus.textLabel?.text = DBUsers.status()
	}

	//.devMARK: - Load methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func loadStatuses() {

		statuses.append("Available")
		statuses.append("Busy")
		statuses.append("At school")
		statuses.append("At the movies")
		statuses.append("At work")
		statuses.append("Battery about to die")
		statuses.append("Can't talk now")
		statuses.append("In a meeting")
		statuses.append("At the gym")
		statuses.append("Sleeping")
		statuses.append("Urgent calls only")
	}

	//.devMARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionCustomStatus() {

		let customStatusView = CustomStatusView()
		let navController = NavigationController(rootViewController: customStatusView)
		navController.isModalInPresentation = true
		navController.modalPresentationStyle = .fullScreen
		present(navController, animated: true)
	}

	//.devMARK: - Helper methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func updateStatus(status: String) {

		cellStatus.textLabel?.text = status
		tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
	}
}

//.devMARK: - UITableViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension StatusView: UITableViewDataSource {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfSections(in tableView: UITableView) -> Int {

		return 3
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if (section == 0) { return 1				}
		if (section == 1) { return statuses.count	}
		if (section == 2) { return 1				}

		return 0
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

		if (section == 0) { return "Your current status is"	}
		if (section == 1) { return "Select your new status"	}

		return nil
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		if (indexPath.section == 0) && (indexPath.row == 0) {
			return cellStatus
		}

		if (indexPath.section == 1) {
			var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
			if (cell == nil) { cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell") }
			cell.textLabel?.text = statuses[indexPath.row]
			return cell
		}

		if (indexPath.section == 2) && (indexPath.row == 0) {
			return cellClear
		}

		return UITableViewCell()
	}
}

//.devMARK: - UITableViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension StatusView: UITableViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)

		if (indexPath.section == 0) {
			actionCustomStatus()
		}

		if (indexPath.section == 1) {
			let status = statuses[indexPath.row]
			DBUsers.update(status: status)
			updateStatus(status: status)
		}

		if (indexPath.section == 2) {
			DBUsers.update(status: "")
			updateStatus(status: "")
		}
	}
}

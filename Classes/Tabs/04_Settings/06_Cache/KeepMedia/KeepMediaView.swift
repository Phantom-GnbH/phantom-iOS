//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class KeepMediaView: UIViewController {

	@IBOutlet private var tableView: UITableView!
	@IBOutlet private var cellWeek: UITableViewCell!
	@IBOutlet private var cellMonth: UITableViewCell!
	@IBOutlet private var cellForever: UITableViewCell!

	private var keepMedia = 0

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Keep Media"

		keepMedia = DBUsers.keepMedia()

		updateDetails()
	}

	//.devMARK: - Helper methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func updateDetails() {

		cellWeek.accessoryType = (keepMedia == KeepMedia.Week) ? .checkmark : .none
		cellMonth.accessoryType = (keepMedia == KeepMedia.Month) ? .checkmark : .none
		cellForever.accessoryType = (keepMedia == KeepMedia.Forever) ? .checkmark : .none

		tableView.reloadData()
	}
}

//.devMARK: - UITableViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension KeepMediaView: UITableViewDataSource {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfSections(in tableView: UITableView) -> Int {

		return 1
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return 3
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		if (indexPath.section == 0) && (indexPath.row == 0) { return cellWeek		}
		if (indexPath.section == 0) && (indexPath.row == 1) { return cellMonth		}
		if (indexPath.section == 0) && (indexPath.row == 2) { return cellForever	}

		return UITableViewCell()
	}
}

//.devMARK: - UITableViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension KeepMediaView: UITableViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)

		if (indexPath.section == 0) && (indexPath.row == 0) { keepMedia = KeepMedia.Week	}
		if (indexPath.section == 0) && (indexPath.row == 1) { keepMedia = KeepMedia.Month	}
		if (indexPath.section == 0) && (indexPath.row == 2) { keepMedia = KeepMedia.Forever	}

		DBUsers.update(keepMedia: keepMedia)

		updateDetails()
	}
}

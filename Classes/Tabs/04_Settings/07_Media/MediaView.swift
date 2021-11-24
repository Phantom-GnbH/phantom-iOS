//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class MediaView: UIViewController {

	@IBOutlet private var tableView: UITableView!
	@IBOutlet private var cellPhoto: UITableViewCell!
	@IBOutlet private var cellVideo: UITableViewCell!
	@IBOutlet private var cellAudio: UITableViewCell!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Media Settings"

		navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewWillAppear(_ animated: Bool) {

		super.viewWillAppear(animated)

		updateCell(selectedNetwork: DBUsers.networkPhoto(), cell: cellPhoto)
		updateCell(selectedNetwork: DBUsers.networkVideo(), cell: cellVideo)
		updateCell(selectedNetwork: DBUsers.networkAudio(), cell: cellAudio)
	}

	//.devMARK: - Helper methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func updateCell(selectedNetwork: Int, cell: UITableViewCell) {

		if (selectedNetwork == Network.Manual)	{ cell.detailTextLabel?.text = "Manual"				}
		if (selectedNetwork == Network.WiFi)	{ cell.detailTextLabel?.text = "Wi-Fi"				}
		if (selectedNetwork == Network.All)		{ cell.detailTextLabel?.text = "Wi-Fi + Cellular"	}
	}

	//.devMARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionNetwork(mediaType: Int) {

		let networkView = NetworkView(mediaType)
		navigationController?.pushViewController(networkView, animated: true)
	}
}

//.devMARK: - UITableViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension MediaView: UITableViewDataSource {

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

		if (indexPath.section == 0) && (indexPath.row == 0) { return cellPhoto }
		if (indexPath.section == 0) && (indexPath.row == 1) { return cellVideo }
		if (indexPath.section == 0) && (indexPath.row == 2) { return cellAudio }

		return UITableViewCell()
	}
}

//.devMARK: - UITableViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension MediaView: UITableViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)

		if (indexPath.section == 0) && (indexPath.row == 0) { actionNetwork(mediaType: MediaType.Photo)	}
		if (indexPath.section == 0) && (indexPath.row == 1) { actionNetwork(mediaType: MediaType.Video)	}
		if (indexPath.section == 0) && (indexPath.row == 2) { actionNetwork(mediaType: MediaType.Audio)	}
	}
}

//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class NetworkView: UIViewController {

	@IBOutlet private var tableView: UITableView!
	@IBOutlet private var cellManual: UITableViewCell!
	@IBOutlet private var cellWiFi: UITableViewCell!
	@IBOutlet private var cellAll: UITableViewCell!

	private var mediaType = 0
	private var selectedNetwork = 0

	//-------------------------------------------------------------------------------------------------------------------------------------------
	init(_ mediaType: Int) {

		super.init(nibName: nil, bundle: nil)

		self.mediaType = mediaType
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	required init?(coder: NSCoder) {

		super.init(coder: coder)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()

		if (mediaType == MediaType.Photo) { title = "Photo" }
		if (mediaType == MediaType.Video) { title = "Video" }
		if (mediaType == MediaType.Audio) { title = "Audio" }

		if (mediaType == MediaType.Photo) { selectedNetwork = DBUsers.networkPhoto() }
		if (mediaType == MediaType.Video) { selectedNetwork = DBUsers.networkVideo() }
		if (mediaType == MediaType.Audio) { selectedNetwork = DBUsers.networkAudio() }

		updateDetails()
	}

	//.devMARK: - Helper methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func updateDetails() {

		cellManual.accessoryType = (selectedNetwork == Network.Manual) ? .checkmark : .none
		cellWiFi.accessoryType	 = (selectedNetwork == Network.WiFi) ? .checkmark : .none
		cellAll.accessoryType	 = (selectedNetwork == Network.All) ? .checkmark : .none

		tableView.reloadData()
	}
}

//.devMARK: - UITableViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension NetworkView: UITableViewDataSource {

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

		if (indexPath.section == 0) && (indexPath.row == 0) { return cellManual	}
		if (indexPath.section == 0) && (indexPath.row == 1) { return cellWiFi	}
		if (indexPath.section == 0) && (indexPath.row == 2) { return cellAll	}

		return UITableViewCell()
	}
}

//.devMARK: - UITableViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension NetworkView: UITableViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)

		if (indexPath.section == 0) && (indexPath.row == 0) { selectedNetwork = Network.Manual	}
		if (indexPath.section == 0) && (indexPath.row == 1) { selectedNetwork = Network.WiFi	}
		if (indexPath.section == 0) && (indexPath.row == 2) { selectedNetwork = Network.All		}

		if (mediaType == MediaType.Photo) { DBUsers.update(networkPhoto: selectedNetwork) }
		if (mediaType == MediaType.Video) { DBUsers.update(networkVideo: selectedNetwork) }
		if (mediaType == MediaType.Audio) { DBUsers.update(networkAudio: selectedNetwork) }

		updateDetails()
	}
}

//

import UIKit
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class RCLoaderPhoto: NSObject {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func start(_ rcmessage: RCMessage, in tableView: UITableView) {

		if let path = Media.path(photoId: rcmessage.messageId) {
			showMedia(rcmessage, path: path)
		} else {
			loadMedia(rcmessage, in: tableView)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func manual(_ rcmessage: RCMessage, in tableView: UITableView) {

		Media.clearManual(photoId: rcmessage.messageId)
		downloadMedia(rcmessage, in: tableView)
		tableView.reloadData()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	private class func loadMedia(_ rcmessage: RCMessage, in tableView: UITableView) {

		let network = DBUsers.networkPhoto()

		if (network == Network.Manual) || ((network == Network.WiFi) && (GQLNetwork.isWiFi() == false)) {
			rcmessage.mediaStatus = MediaStatus.Manual
		} else {
			downloadMedia(rcmessage, in: tableView)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	private class func downloadMedia(_ rcmessage: RCMessage, in tableView: UITableView) {

		rcmessage.mediaStatus = MediaStatus.Loading

		MediaDownload.photo(rcmessage.messageId) { path, error in
			if (error == nil) {
				showMedia(rcmessage, path: path)
			} else {
				rcmessage.mediaStatus = MediaStatus.Manual
			}
			tableView.reloadData()
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	private class func showMedia(_ rcmessage: RCMessage, path: String) {

		rcmessage.photoImage = UIImage(path: path)
		rcmessage.mediaStatus = MediaStatus.Succeed
	}
}

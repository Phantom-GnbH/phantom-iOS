//

import UIKit
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class RCLoaderVideo: NSObject {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func start(_ rcmessage: RCMessage, in tableView: UITableView) {

		if let path = Media.path(videoId: rcmessage.messageId) {
			showMedia(rcmessage, path: path)
		} else {
			loadMedia(rcmessage, in: tableView)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func manual(_ rcmessage: RCMessage, in tableView: UITableView) {

		Media.clearManual(videoId: rcmessage.messageId)
		downloadMedia(rcmessage, in: tableView)
		tableView.reloadData()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	private class func loadMedia(_ rcmessage: RCMessage, in tableView: UITableView) {

		let network = DBUsers.networkVideo()

		if (network == Network.Manual) || ((network == Network.WiFi) && (GQLNetwork.isWiFi() == false)) {
			rcmessage.mediaStatus = MediaStatus.Manual
		} else {
			downloadMedia(rcmessage, in: tableView)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	private class func downloadMedia(_ rcmessage: RCMessage, in tableView: UITableView) {

		rcmessage.mediaStatus = MediaStatus.Loading

		MediaDownload.video(rcmessage.messageId) { path, error in
			if (error == nil) {
				Cryptor.decrypt(path: path)
				showMedia(rcmessage, path: path)
			} else {
				rcmessage.mediaStatus = MediaStatus.Manual
			}
			tableView.reloadData()
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	private class func showMedia(_ rcmessage: RCMessage, path: String) {

		let thumbnail = Video.thumbnail(path)

		rcmessage.videoPath = path
		rcmessage.videoThumbnail = thumbnail.square(to: 200)
		rcmessage.mediaStatus = MediaStatus.Succeed
	}
}

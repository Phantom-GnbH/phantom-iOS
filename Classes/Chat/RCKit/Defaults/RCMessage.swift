//

import UIKit
import CoreLocation

//-----------------------------------------------------------------------------------------------------------------------------------------------
class RCMessage: NSObject {

	var chatId = ""
	var messageId = ""

	var userId = ""
	var userFullname = ""
	var userInitials = ""
	var userPictureAt: TimeInterval = 0

	var type = ""
	var text = ""

	var photoWidth = 0
	var photoHeight = 0
	var videoDuration = 0
	var audioDuration = 0

	var latitude: CLLocationDegrees = 0
	var longitude: CLLocationDegrees = 0

	var isDataQueued = false
	var isMediaQueued = false
	var isMediaFailed = false
	var isMediaOrigin = false

	var createdAt: TimeInterval = 0

	var incoming = false
	var outgoing = false

	var videoPath: String?
	var audioPath: String?

	var photoImage: UIImage?
	var stickerImage: UIImage?
	var videoThumbnail: UIImage?
	var locationThumbnail: UIImage?

	var audioStatus = AudioStatus.Stopped
	var mediaStatus = MediaStatus.Unknown

	var audioCurrent: TimeInterval = 0

	var sizeBubble = CGSize.zero

	//.devMARK: - Initialization methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	override init() {

		super.init()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	init(_ dbmessage: DBMessage) {

		super.init()

		chatId = dbmessage.chatId
		messageId = dbmessage.objectId

		userId = dbmessage.userId
		userFullname = dbmessage.userFullname
		userInitials = dbmessage.userInitials
		userPictureAt = dbmessage.userPictureAt

		type = dbmessage.type
		text = dbmessage.text

		photoWidth = dbmessage.photoWidth
		photoHeight = dbmessage.photoHeight
		videoDuration = dbmessage.videoDuration
		audioDuration = dbmessage.audioDuration

		latitude = dbmessage.latitude
		longitude = dbmessage.longitude

		isMediaQueued = dbmessage.isMediaQueued
		isMediaFailed = dbmessage.isMediaFailed
		isMediaOrigin = isMediaQueued ? MediaQueue.check(gqldb, key: messageId) : false

		createdAt = dbmessage.createdAt.timestamp()

		incoming = dbmessage.incoming()
		outgoing = dbmessage.outgoing()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func update(_ dbmessage: DBMessage) {

		isMediaQueued = dbmessage.isMediaQueued
		isMediaFailed = dbmessage.isMediaFailed
	}
}

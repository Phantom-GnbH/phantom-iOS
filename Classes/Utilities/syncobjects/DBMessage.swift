//

import Foundation
import CoreLocation
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class DBMessage: NSObject, GQLObject {

	@objc var objectId = ""

	@objc var chatId = ""

	@objc var userId = ""
	@objc var userFullname = ""
	@objc var userInitials = ""
	@objc var userPictureAt: TimeInterval = 0

	@objc var type = ""
	@objc var text = ""

	@objc var photoWidth = 0
	@objc var photoHeight = 0
	@objc var videoDuration = 0
	@objc var audioDuration = 0

	@objc var latitude: CLLocationDegrees = 0
	@objc var longitude: CLLocationDegrees = 0

	@objc var isMediaQueued = false
	@objc var isMediaFailed = false

	@objc var isDeleted = false

	@objc var createdAt = Date()
	@objc var updatedAt = Date()

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func primaryKey() -> String {

		return "objectId"
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension DBMessage {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func incoming() -> Bool {

		return (userId != GQLAuth.userId())
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func outgoing() -> Bool {

		return (userId == GQLAuth.userId())
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension DBMessage {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func insertLazy() {

		let values = self.values()
		gqldb.insert(table(), values)

		let variables: [String: Any] = ["object": values]
		gqlsync.lazy("CreateDBMessage", variables, objectId)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func updateLazy() {

		updatedAt = Date()

		let values = self.values()
		gqldb.update(table(), values)

		let variables: [String: Any] = ["object": values]
		gqlsync.lazy("UpdateDBMessage", variables, objectId)
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension DBMessage {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func update(isMediaQueued value: Bool) {

		if (isMediaQueued != value) {
			isMediaQueued = value
			updateLazy()
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func update(isMediaFailed value: Bool) {

		if (isMediaFailed != value) {
			isMediaFailed = value
			updateLazy()
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func update(isDeleted value: Bool) {

		if (isDeleted != value) {
			isDeleted = value
			updateLazy()
		}
	}
}

//

import Foundation
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class MediaQueue: NSObject, GQLObject {

	@objc var objectId = ""

	@objc var isQueued = true
	@objc var isFailed = false

	@objc var updatedAt: Double = Date().timeIntervalSince1970

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func primaryKey() -> String {

		return "objectId"
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension MediaQueue {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func create(_ dbmessage: DBMessage) {

		let mediaQueue = MediaQueue()
		mediaQueue.objectId = dbmessage.objectId
		mediaQueue.insert(gqldb)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func restart(_ objectId: String) {

		if let mediaQueue = MediaQueue.fetchOne(gqldb, key: objectId) {
			mediaQueue.update(isFailed: false)
		}
		if let dbmessage = DBMessage.fetchOne(gqldb, key: objectId) {
			dbmessage.update(isMediaFailed: false)
		}
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension MediaQueue {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func update(isQueued value: Bool) {

		if (isQueued != value) {
			isQueued = value
			update(gqldb)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func update(isFailed value: Bool) {

		if (isFailed != value) {
			isFailed = value
			update(gqldb)
		}
	}
}

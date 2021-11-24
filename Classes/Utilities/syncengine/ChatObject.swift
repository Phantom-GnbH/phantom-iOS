//

import Foundation
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class ChatObject: NSObject, GQLObject {

	@objc var objectId = ""

	@objc var isGroup = false
	@objc var isPrivate = false

	@objc var details = ""
	@objc var initials = ""

	@objc var userId = ""
	@objc var pictureAt: TimeInterval = 0

	@objc var lastMessageId = ""
	@objc var lastMessageText = ""
	@objc var lastMessageAt: TimeInterval = 0

	@objc var typing = false
	@objc var typingUsers = ""

	@objc var lastRead: TimeInterval = 0
	@objc var mutedUntil: TimeInterval = 0
	@objc var unreadCount = 0

	@objc var isDeleted = false
	@objc var isArchived = false

	@objc var isGroupDeleted = false

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func primaryKey() -> String {

		return "objectId"
	}
}

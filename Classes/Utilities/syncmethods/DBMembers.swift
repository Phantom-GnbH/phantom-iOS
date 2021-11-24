//

import Foundation

//-----------------------------------------------------------------------------------------------------------------------------------------------
class DBMembers: NSObject {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func create(_ chatId: String, _ userIds: [String]) {

		for userId in userIds {
			update(chatId, userId, isActive: true)
		}
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension DBMembers {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func update(_ chatId: String, _ userId: String, isActive: Bool) {

		let objectId = "\(chatId)-\(userId)".sha1()

		if let dbmember = DBMember.fetchOne(gqldb, key: objectId) {
			dbmember.update(isActive: isActive)
		} else {
			let dbmember = DBMember()
			dbmember.objectId = objectId
			dbmember.chatId = chatId
			dbmember.userId = userId
			dbmember.isActive = isActive
			dbmember.insertLazy()
		}
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension DBMembers {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func userIds(_ chatId: String) -> [String] {

		var userIds: [String] = []

		for dbmember in DBMember.fetchAll(gqldb, "chatId = ? AND isActive = ?", [chatId, true]) {
			userIds.append(dbmember.userId)
		}

		return userIds
	}
}

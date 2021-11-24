//

import Foundation
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class DBSingle: NSObject, GQLObject {

	@objc var objectId = ""

	@objc var chatId = ""

	@objc var userId1 = ""
	@objc var fullname1 = ""
	@objc var initials1 = ""
	@objc var pictureAt1: TimeInterval = 0

	@objc var userId2 = ""
	@objc var fullname2 = ""
	@objc var initials2 = ""
	@objc var pictureAt2: TimeInterval = 0

	@objc var createdAt = Date()
	@objc var updatedAt = Date()

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func primaryKey() -> String {

		return "objectId"
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension DBSingle {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func insertLazy() {

		let values = self.values()
		gqldb.insert(table(), values)

		let variables: [String: Any] = ["object": values]
		gqlsync.lazy("CreateDBSingle", variables, objectId)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func updateLazy() {

		updatedAt = Date()

		let values = self.values()
		gqldb.update(table(), values)

		let variables: [String: Any] = ["object": values]
		gqlsync.lazy("UpdateDBSingle", variables, objectId)
	}
}

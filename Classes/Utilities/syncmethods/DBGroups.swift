//

import Foundation
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class DBGroups: NSObject {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func create(_ name: String, _ userIds: [String]) {

		let objectId = UUID().uuidString

		DBDetails.create(objectId, userIds)
		DBMembers.create(objectId, userIds)

		let dbgroup = DBGroup()
		dbgroup.objectId = objectId
		dbgroup.chatId = objectId
		dbgroup.name = name
		dbgroup.ownerId = GQLAuth.userId()
		dbgroup.members = userIds.count
		dbgroup.insertLazy()
	}
}

//

import Foundation
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class DBRelations: NSObject {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func update(_ userId2: String, isFriend: Bool) {

		let userId1 = GQLAuth.userId()
		let objectId = "\(userId1)-\(userId2)".sha1()

		if let dbrelation = DBRelation.fetchOne(gqldb, key: objectId) {
			dbrelation.update(isFriend: isFriend)
		} else {
			let dbrelation = DBRelation()
			dbrelation.objectId = objectId
			dbrelation.userId1 = userId1
			dbrelation.userId2 = userId2
			dbrelation.isFriend = isFriend
			dbrelation.insertLazy()
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func update(_ userId2: String, isBlocked: Bool) {

		let userId1 = GQLAuth.userId()
		let objectId = "\(userId1)-\(userId2)".sha1()

		if let dbrelation = DBRelation.fetchOne(gqldb, key: objectId) {
			dbrelation.update(isBlocked: isBlocked)
		} else {
			let dbrelation = DBRelation()
			dbrelation.objectId = objectId
			dbrelation.userId1 = userId1
			dbrelation.userId2 = userId2
			dbrelation.isBlocked = isBlocked
			dbrelation.insertLazy()
		}
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension DBRelations {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func isFriend(_ userId2: String) -> Bool {

		let userId1 = GQLAuth.userId()

		return DBRelation.check(gqldb, "userId1 = ? AND userId2 = ? AND isFriend = ?", [userId1, userId2, true])
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func isBlocked(_ userId2: String) -> Bool {

		let userId1 = GQLAuth.userId()

		return DBRelation.check(gqldb, "userId1 = ? AND userId2 = ? AND isBlocked = ?", [userId1, userId2, true])
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func isBlocker(_ userId2: String) -> Bool {

		let userId1 = GQLAuth.userId()

		return DBRelation.check(gqldb, "userId1 = ? AND userId2 = ? AND isBlocked = ?", [userId2, userId1, true])
	}
}

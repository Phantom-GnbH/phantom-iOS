//

import Foundation
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class DBUsers: NSObject {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func create(_ objectId: String, _ email: String) {

		let dbuser = DBUser()
		dbuser.objectId = objectId
		dbuser.email = email
		dbuser.insertLazy()
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension DBUsers {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func fullname() -> String {

		let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId())
		return dbuser?.fullname ?? ""
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func status() -> String {

		let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId())
		return dbuser?.status ?? ""
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func keepMedia() -> Int {

		let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId())
		return dbuser?.keepMedia ?? KeepMedia.Forever
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func networkPhoto() -> Int {

		let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId())
		return dbuser?.networkPhoto ?? Network.All
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func networkVideo() -> Int {

		let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId())
		return dbuser?.networkVideo ?? Network.All
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func networkAudio() -> Int {

		let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId())
		return dbuser?.networkAudio ?? Network.All
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension DBUsers {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func update(status: String) {

		if let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId()) {
			dbuser.update(status: status)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func update(keepMedia: Int) {

		if let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId()) {
			dbuser.update(keepMedia: keepMedia)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func update(networkPhoto: Int) {

		if let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId()) {
			dbuser.update(networkPhoto: networkPhoto)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func update(networkVideo: Int) {

		if let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId()) {
			dbuser.update(networkVideo: networkVideo)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func update(networkAudio: Int) {

		if let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId()) {
			dbuser.update(networkAudio: networkAudio)
		}
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension DBUsers {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func updateActive() {

		if let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId()) {
			dbuser.update(lastActive: Date().timestamp())
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func updateTerminate() {

		if let dbuser = DBUser.fetchOne(gqldb, key: GQLAuth.userId()) {
			dbuser.update(lastTerminate: Date().timestamp())
		}
	}
}

//

import Foundation
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class LastUpdated: NSObject {

	private static var initialized = false

	private static var cache: [String: TimeInterval] = [:]

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class subscript(_ table: String) -> String {

		loadCache()

		if let cached = cache[table] {
			return GQLDate[cached]
		}

		return GQLDate[0]
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension LastUpdated {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	private class func loadCache() {

		if (initialized) { return }

		if let temp = UserDefaults.object(key: "LastUpdated") as? [String: TimeInterval] {
			cache = temp
		}

		initialized = true
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	private class func saveCache() {

		UserDefaults.setObject(cache, key: "LastUpdated")
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension LastUpdated {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func update(_ table: String, _ values: [String: Any]) {

		if let updatedAt = values["updatedAt"] as? String {
			update(table, updatedAt)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func update(_ table: String, _ updatedAt: String) {

		update(table, GQLDate[updatedAt].timeIntervalSince1970)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func update(_ table: String, _ updatedAt: TimeInterval) {

		loadCache()

		if let cached = cache[table] {
			if (updatedAt <= cached) {
				return
			}
		}
		cache[table] = updatedAt

		saveCache()
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension LastUpdated {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func clear(_ table: String) {

		cache.removeValue(forKey: table)

		saveCache()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func cleanup() {

		cache.removeAll()

		saveCache()
	}
}

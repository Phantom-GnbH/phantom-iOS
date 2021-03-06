//

import Foundation

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension UserDefaults {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func setObject(_ value: Any, key: String) {

		UserDefaults.standard.set(value, forKey: key)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func removeObject(key: String) {

		UserDefaults.standard.removeObject(forKey: key)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func object(key: String) -> Any? {

		return UserDefaults.standard.object(forKey: key)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func string(key: String) -> String? {

		return UserDefaults.standard.string(forKey: key)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func integer(key: String) -> Int {

		return UserDefaults.standard.integer(forKey: key)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func bool(key: String) -> Bool {

		return UserDefaults.standard.bool(forKey: key)
	}
}

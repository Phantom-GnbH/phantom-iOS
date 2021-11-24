//

import Foundation

//-----------------------------------------------------------------------------------------------------------------------------------------------
class File: NSObject {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func temp(_ ext: String) -> String {

		let name = UUID().uuidString
		let file = "\(name).\(ext)"
		return Dir.cache(file)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func exist(_ path: String) -> Bool {

		return FileManager.default.fileExists(atPath: path)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func remove(_ path: String) {

		try? FileManager.default.removeItem(at: URL(fileURLWithPath: path))
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func copy(_ src: String, _ dest: String, _ overwrite: Bool) {

		if (overwrite) { remove(dest) }

		if (exist(dest) == false) {
			try? FileManager.default.copyItem(atPath: src, toPath: dest)
		}
	}
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension File {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func created(_ path: String) -> Date {

		let attributes = try! FileManager.default.attributesOfItem(atPath: path)
		return attributes[.creationDate] as! Date
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func modified(_ path: String) -> Date {

		let attributes = try! FileManager.default.attributesOfItem(atPath: path)
		return attributes[.modificationDate] as! Date
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func size(_ path: String) -> Int64 {

		let attributes = try! FileManager.default.attributesOfItem(atPath: path)
		return attributes[.size] as! Int64
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func diskFree() -> Int64 {

		let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
		let attributes = try! FileManager.default.attributesOfFileSystem(forPath: path)
		return attributes[.systemFreeSize] as! Int64
	}
}

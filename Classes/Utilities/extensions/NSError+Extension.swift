//

import Foundation

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension NSError {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	convenience init(_ description: String, code: Int) {

		let domain = Bundle.main.bundleIdentifier ?? ""
		let userInfo = [NSLocalizedDescriptionKey: description]

		self.init(domain: domain, code: code, userInfo: userInfo)
	}
}

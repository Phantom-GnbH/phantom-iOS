//

import Foundation

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension DispatchQueue {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func async(after delay: TimeInterval, execute: @escaping () -> Void) {

		asyncAfter(deadline: .now() + delay, execute: execute)
	}
}

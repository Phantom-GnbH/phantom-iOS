//

import Foundation

//-----------------------------------------------------------------------------------------------------------------------------------------------
extension Array where Element: Hashable {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	mutating func appendUnique(_ element: Element) {

		var array = self

		if !array.contains(element) {
			array.append(element)
		}

		self = array
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	mutating func removeDuplicates() {

		var array: [Element] = []

		for element in self {
			if !array.contains(element) {
				array.append(element)
			}
		}

		self = array
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	mutating func remove(_ element: Element) {

		var array = self

		while let index = array.firstIndex(of: element) {
			array.remove(at: index)
		}

		self = array
	}
}

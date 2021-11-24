//

import Foundation

//-----------------------------------------------------------------------------------------------------------------------------------------------
class Convert: NSObject {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func dateToShort(_ date: Date) -> String {

		return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func dateToMediumTime(_ date: Date) -> String {

		return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func timestampToMediumTime(_ timestamp: TimeInterval) -> String {

		let date = Date(timestamp: timestamp)

		return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func dateToDayMonthTime(_ date: Date) -> String {

		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMMM, HH:mm"

		return formatter.string(from: date)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func timestampToDayMonthTime(_ timestamp: TimeInterval) -> String {

		let date = Date(timestamp: timestamp)

		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMMM, HH:mm"

		return formatter.string(from: date)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func timestampToElapsed(_ timestamp: TimeInterval) -> String {

		var elapsed = ""

		let date = Date(timestamp: timestamp)
		let seconds = Date().timeIntervalSince(date)

		if (seconds < 60) {
			elapsed = "Just now"
		} else if (seconds < 60 * 60) {
			let minutes = Int(seconds / 60)
			let text = (minutes > 1) ? "mins" : "min"
			elapsed = "\(minutes) \(text)"
		} else if (seconds < 24 * 60 * 60) {
			let hours = Int(seconds / (60 * 60))
			let text = (hours > 1) ? "hours" : "hour"
			elapsed = "\(hours) \(text)"
		} else if (seconds < 7 * 24 * 60 * 60) {
			let formatter = DateFormatter()
			formatter.dateFormat = "EEE"
			elapsed = formatter.string(from: date)
		} else {
			let formatter = DateFormatter()
			formatter.dateFormat = "dd.MM.yy"
			elapsed = formatter.string(from: date)
		}

		return elapsed
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func timestampToCustom(_ timestamp: TimeInterval) -> String {

		let date = Date(timestamp: timestamp)
		let seconds = Date().timeIntervalSince(date)

		let formatter = DateFormatter()
		if (seconds < 24 * 60 * 60) {
			formatter.dateFormat = "HH:mm"
		} else if (seconds < 7 * 24 * 60 * 60) {
			formatter.dateFormat = "EEE"
		} else {
			formatter.dateFormat = "dd.MM.yy"
		}

		return formatter.string(from: date)
	}
}

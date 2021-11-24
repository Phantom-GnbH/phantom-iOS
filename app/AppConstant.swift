//

import Foundation

//-----------------------------------------------------------------------------------------------------------------------------------------------
enum Notifications {

	static let AppStarted		= "NotificationAppStarted"
	static let AppWillResign	= "NotificationAppWillResign"

	static let UserLoggedIn		= "NotificationUserLoggedIn"
	static let UserLoggedOut	= "NotificationUserLoggedOut"

	static let CleanupChatView	= "NotificationCleanupChatView"
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
enum MessageType {

	static let Text		= "text"
	static let Emoji	= "emoji"
	static let Photo	= "photo"
	static let Video	= "video"
	static let Audio	= "audio"
	static let Sticker	= "sticker"
	static let Location	= "location"
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
enum MessageStatus {

	static let Queued	= "Queued"
	static let Failed	= "Failed"
	static let Sent		= "Sent"
	static let Read		= "Read"
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
enum KeepMedia {

	static let Week		= 1
	static let Month	= 2
	static let Forever	= 3
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
enum Network {

	static let Manual	= 1
	static let WiFi		= 2
	static let All		= 3
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
enum MediaType {

	static let Photo	= 1
	static let Video	= 2
	static let Audio	= 3
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
enum MediaStatus {

	static let Unknown	= 0
	static let Loading	= 1
	static let Manual	= 2
	static let Succeed	= 3
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
enum AudioStatus {

	static let Stopped	= 1
	static let Playing	= 2
	static let Paused	= 3
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
enum App {

	static let DefaultTab		= 0
	static let MaxVideoDuration	= TimeInterval(10)
	static let TextShareApp		= "Check out https://related.chat"
}

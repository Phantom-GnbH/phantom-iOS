//

import AVFoundation

//-----------------------------------------------------------------------------------------------------------------------------------------------
class Audio: NSObject {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func duration(_ path: String) -> Int {

		let asset = AVURLAsset(url: URL(fileURLWithPath: path))
		return Int(round(CMTimeGetSeconds(asset.duration)))
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func playMessageIncoming() {

		let path = Dir.application("rckit_incoming.aiff")
		RCAudioPlayer.shared.playSound(path)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func playMessageOutgoing() {

		let path = Dir.application("rckit_outgoing.aiff")
		RCAudioPlayer.shared.playSound(path)
	}
}

//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class AllMediaCell: UICollectionViewCell {

	@IBOutlet private var imageItem: UIImageView!
	@IBOutlet private var imageVideo: UIImageView!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func bindData(_ dbmessage: DBMessage) {

		imageItem.image = nil

		if (dbmessage.type == MessageType.Photo) {
			bindPicture(dbmessage)
		}
		if (dbmessage.type == MessageType.Video) {
			bindVideo(dbmessage)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func bindPicture(_ dbmessage: DBMessage) {

		imageVideo.isHidden = true

		if let path = Media.path(photoId: dbmessage.objectId) {
			imageItem.image = UIImage.image(path, size: 160)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func bindVideo(_ dbmessage: DBMessage) {

		imageVideo.isHidden = false

		if let path = Media.path(videoId: dbmessage.objectId) {
			DispatchQueue(label: "bindVideo").async {
				let thumbnail = Video.thumbnail(path)
				DispatchQueue.main.async {
					self.imageItem.image = thumbnail.square(to: 160)
				}
			}
		}
	}
}

//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class BlockedCell: UITableViewCell {

	@IBOutlet private var imageUser: UIImageView!
	@IBOutlet private var labelInitials: UILabel!
	@IBOutlet private var labelName: UILabel!

	private var objectId = ""

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func bindData(_ dbuser: DBUser) {

		labelName.text = dbuser.fullname
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func loadImage(_ dbuser: DBUser) {

		objectId = dbuser.objectId

		imageUser.image = nil
		labelInitials.text = dbuser.initials()

		if let path = Media.path(userId: dbuser.objectId) {
			imageUser.image = UIImage.image(path, size: 40)
			labelInitials.text = nil
		} else {
			downloadImage(dbuser)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func downloadImage(_ dbuser: DBUser) {

		MediaDownload.user(dbuser.objectId, dbuser.pictureAt) { image, error in
			if (self.objectId == dbuser.objectId) {
				if (error == nil) {
					self.imageUser.image = image?.square(to: 40)
					self.labelInitials.text = nil
				} else if (error!.code() == 102) {
					self.downloadLater(dbuser)
				}
			}
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func downloadLater(_ dbuser: DBUser) {

		DispatchQueue.main.async(after: 0.5) {
			if (self.objectId == dbuser.objectId) {
				if (self.imageUser.image == nil) {
					self.downloadImage(dbuser)
				}
			}
		}
	}
}

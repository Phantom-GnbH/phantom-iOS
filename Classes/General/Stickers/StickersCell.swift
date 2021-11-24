//

import UIKit
import PINRemoteImage

//-----------------------------------------------------------------------------------------------------------------------------------------------
class StickersCell: UICollectionViewCell {

	@IBOutlet var imageItem: UIImageView!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func bindData(_ sticker: String) {

		let url = URL(string: sticker)
		imageItem.pin_setImage(from: url)
	}
}

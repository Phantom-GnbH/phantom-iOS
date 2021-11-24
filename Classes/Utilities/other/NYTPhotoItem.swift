//

import NYTPhotoViewer

//-----------------------------------------------------------------------------------------------------------------------------------------------
class NYTPhotoItem: NSObject, NYTPhoto {

	var image: UIImage?
	var imageData: Data?
	var placeholderImage: UIImage?
	var attributedCaptionTitle: NSAttributedString?
	var attributedCaptionSummary: NSAttributedString?
	var attributedCaptionCredit: NSAttributedString?

	var objectId = ""

	//-------------------------------------------------------------------------------------------------------------------------------------------
	convenience init(image: UIImage) {

		self.init()
		self.image = image
	}
}

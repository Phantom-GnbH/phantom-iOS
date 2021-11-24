//

import NYTPhotoViewer

//-----------------------------------------------------------------------------------------------------------------------------------------------
class NYTPhotoSource: NSObject, NYTPhotoViewerDataSource {

	var photoItems: [NYTPhoto] = []

	//-------------------------------------------------------------------------------------------------------------------------------------------
	convenience init(photoItems: [NYTPhoto]) {

		self.init()
		self.photoItems = photoItems
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	var numberOfPhotos: NSNumber? {

		return NSNumber(value: photoItems.count)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func index(of photo: NYTPhoto) -> Int {

		if let photoItem = photo as? NYTPhotoItem {
			if let index = photoItems.firstIndex(where: { $0.image == photoItem.image }) {
				return index
			}
		}
		return 0
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func photo(at index: Int) -> NYTPhoto? {

		if (photoItems.count > index) {
			return photoItems[index]
		}
		return nil
	}
}

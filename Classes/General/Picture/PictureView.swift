//

import NYTPhotoViewer

//-----------------------------------------------------------------------------------------------------------------------------------------------
class PictureView: NYTPhotosViewController {

	private var photoDataSource: NYTPhotoSource!
	private var isShareButtonVisible = false

	//-------------------------------------------------------------------------------------------------------------------------------------------
	convenience init(image: UIImage, isShareButtonVisible: Bool = false) {

		let photoItem = NYTPhotoItem(image: image)
		let dataSource = NYTPhotoSource(photoItems: [photoItem])
		self.init(dataSource: dataSource, initialPhoto: nil, delegate: nil)

		self.photoDataSource = dataSource
		self.isShareButtonVisible = isShareButtonVisible
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	convenience init(chatId: String, messageId: String, isShareButtonVisible: Bool = true) {

		var photoItems: [NYTPhotoItem] = []
		var initialPhoto: NYTPhotoItem? = nil

		let attributesTitle = [NSAttributedString.Key.foregroundColor: UIColor.white,
							   NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
		let attributesCredit = [NSAttributedString.Key.foregroundColor: UIColor.gray,
								NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)]

		let arguments: [String: Any] = [":chatId": chatId, ":type": MessageType.Photo, ":false": false]

		let dbmessages = DBMessage.fetchAll(gqldb, "chatId = :chatId AND type = :type AND isDeleted = :false", arguments, order: "createdAt")

		for dbmessage in dbmessages {
			if let path = Media.path(photoId: dbmessage.objectId) {
				let title = dbmessage.userFullname
				let credit = Convert.dateToDayMonthTime(dbmessage.createdAt)

				let photoItem = NYTPhotoItem()
				photoItem.image = UIImage(path: path)
				photoItem.attributedCaptionTitle = NSAttributedString(string: title, attributes: attributesTitle)
				photoItem.attributedCaptionCredit = NSAttributedString(string: credit, attributes: attributesCredit)
				photoItem.objectId = dbmessage.objectId

				if (dbmessage.objectId == messageId) {
					initialPhoto = photoItem
				}
				photoItems.append(photoItem)
			}
		}

		if (initialPhoto == nil) { initialPhoto = photoItems.first }

		let dataSource = NYTPhotoSource(photoItems: photoItems)
		self.init(dataSource: dataSource, initialPhoto: initialPhoto, delegate: nil)

		self.photoDataSource = dataSource
		self.isShareButtonVisible = isShareButtonVisible
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()

		if (isShareButtonVisible) {
			rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionShare))
		} else {
			rightBarButtonItem = nil
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override var prefersStatusBarHidden: Bool {

		return false
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override var preferredStatusBarStyle: UIStatusBarStyle {

		return .lightContent
	}

	//.devMARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionShare() {

		if let photoItem = currentlyDisplayedPhoto as? NYTPhotoItem {
			if let image = photoItem.image {
				let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
				present(activityViewController, animated: true)
			}
		}
	}
}

//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
@objc protocol StickersDelegate: AnyObject {

	func didSelectSticker(sticker: UIImage)
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
class StickersView: UIViewController {

	@IBOutlet weak var delegate: StickersDelegate?

	@IBOutlet private var collectionView: UICollectionView!

	private var stickers: [String] = []

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Stickers"

		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(actionDismiss))

		collectionView.register(UINib(nibName: "StickersCell", bundle: nil), forCellWithReuseIdentifier: "StickersCell")

		loadStickers()
	}

	//.devMARK: - Load stickers
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func loadStickers() {

		for index in 1...78 {
			let sticker = String(format: "https://related.chat/stickers/sticker%02d.png", index)
			stickers.append(sticker)
		}
	}

	//.devMARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionDismiss() {

		dismiss(animated: true)
	}
}

//.devMARK: - UICollectionViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension StickersView: UICollectionViewDataSource {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfSections(in collectionView: UICollectionView) -> Int {

		return 1
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return stickers.count
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickersCell", for: indexPath) as! StickersCell

		cell.bindData(stickers[indexPath.item])

		return cell
	}
}

//.devMARK: - UICollectionViewDelegateFlowLayout
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension StickersView: UICollectionViewDelegateFlowLayout {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		let screenWidth = UIScreen.main.bounds.size.width
		return CGSize(width: screenWidth/3, height: screenWidth/3)
	}
}

//.devMARK: - UICollectionViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension StickersView: UICollectionViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		collectionView.deselectItem(at: indexPath, animated: true)

		if let cell = collectionView.cellForItem(at: indexPath) as? StickersCell {
			if let image = cell.imageItem.image {
				delegate?.didSelectSticker(sticker: image)
			}
		}

		dismiss(animated: true)
	}
}

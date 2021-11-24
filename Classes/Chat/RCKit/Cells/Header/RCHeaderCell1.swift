//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class RCHeaderCell1: RCMessagesCell {

	private var indexPath: IndexPath!
	private var messagesView: RCMessagesView!

	private var labelText: UILabel!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func bindData(_ messagesView: RCMessagesView, at indexPath: IndexPath) {

		self.indexPath = indexPath
		self.messagesView = messagesView

		let rcmessage = messagesView.rcmessageAt(indexPath)

		backgroundColor = UIColor.clear

		if (labelText == nil) {
			labelText = UILabel()
			labelText.font = RCKit.headerUpperFont
			labelText.textColor = RCKit.headerUpperColor
			contentView.addSubview(labelText)
		}

		labelText.textAlignment = rcmessage.incoming ? .center : .center
		labelText.text = messagesView.textHeaderUpper(indexPath)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func layoutSubviews() {

		super.layoutSubviews()

		let widthTable = messagesView.tableView.frame.size.width

		let width = widthTable - RCKit.headerUpperLeft - RCKit.headerUpperRight
		let height = (labelText.text != nil) ? RCKit.headerUpperHeight : 0

		labelText.frame = CGRect(x: RCKit.headerUpperLeft, y: 0, width: width, height: height)
	}

	//.devMARK: - Size methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func height(_ messagesView: RCMessagesView, at indexPath: IndexPath) -> CGFloat {

		return (messagesView.textHeaderUpper(indexPath) != nil) ? RCKit.headerUpperHeight : 0
	}
}

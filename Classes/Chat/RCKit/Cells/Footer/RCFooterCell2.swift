//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class RCFooterCell2: RCMessagesCell {

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
			labelText.font = RCKit.footerLowerFont
			labelText.textColor = RCKit.footerLowerColor
			contentView.addSubview(labelText)
		}

		labelText.textAlignment = rcmessage.incoming ? .left : .right
		labelText.text = messagesView.textFooterLower(indexPath)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func layoutSubviews() {

		super.layoutSubviews()

		let widthTable = messagesView.tableView.frame.size.width

		let width = widthTable - RCKit.footerLowerLeft - RCKit.footerLowerRight
		let height = (labelText.text != nil) ? RCKit.footerLowerHeight : 0

		labelText.frame = CGRect(x: RCKit.footerLowerLeft, y: 0, width: width, height: height)
	}

	//.devMARK: - Size methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func height(_ messagesView: RCMessagesView, at indexPath: IndexPath) -> CGFloat {

		return (messagesView.textFooterLower(indexPath) != nil) ? RCKit.footerLowerHeight : 0
	}
}

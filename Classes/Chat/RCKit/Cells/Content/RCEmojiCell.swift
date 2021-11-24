//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class RCEmojiCell: RCBaseCell {

	private var textView: UITextView!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func bindData(_ messagesView: RCMessagesView, at indexPath: IndexPath) {

		super.bindData(messagesView, at: indexPath)

		let rcmessage = messagesView.rcmessageAt(indexPath)

		viewBubble.backgroundColor = rcmessage.incoming ? RCKit.emojiBubbleColorIncoming : RCKit.emojiBubbleColorOutgoing

		if (textView == nil) {
			textView = UITextView()
			textView.font = RCKit.emojiFont
			textView.isEditable = false
			textView.isSelectable = false
			textView.isScrollEnabled = false
			textView.isUserInteractionEnabled = false
			textView.backgroundColor = UIColor.clear
			textView.textContainer.lineFragmentPadding = 0
			textView.textContainerInset = RCKit.emojiInset
			viewBubble.addSubview(textView)
		}

		textView.text = rcmessage.text
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func layoutSubviews() {

		let size = RCEmojiCell.size(messagesView, at: indexPath)

		super.layoutSubviews(size)

		textView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
	}

	//.devMARK: - Size methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func height(_ messagesView: RCMessagesView, at indexPath: IndexPath) -> CGFloat {

		let size = self.size(messagesView, at: indexPath)
		return size.height
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func size(_ messagesView: RCMessagesView, at indexPath: IndexPath) -> CGSize {

		let rcmessage = messagesView.rcmessageAt(indexPath)

		if (rcmessage.sizeBubble == CGSize.zero) {
			calculate(rcmessage)
		}

		return rcmessage.sizeBubble
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	private class func calculate(_ rcmessage: RCMessage) {

		let maxwidth = RCKit.emojiBubbleWidthMax - RCKit.emojiInsetLeft - RCKit.emojiInsetRight

		let rect = rcmessage.text.boundingRect(with: CGSize(width: maxwidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: RCKit.emojiFont], context: nil)

		let width = rect.size.width + RCKit.emojiInsetLeft + RCKit.emojiInsetRight
		let height = rect.size.height + RCKit.emojiInsetTop + RCKit.emojiInsetBottom

		let widthBubble = CGFloat.maximum(width, RCKit.emojiBubbleWidthMin)
		let heightBubble = CGFloat.maximum(height, RCKit.emojiBubbleHeightMin)

		rcmessage.sizeBubble = CGSize(width: widthBubble, height: heightBubble)
	}
}

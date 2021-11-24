//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class RCLocationCell: RCBaseCell {

	private var imageViewThumb: UIImageView!
	private var activityIndicator: UIActivityIndicatorView!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func bindData(_ messagesView: RCMessagesView, at indexPath: IndexPath) {

		super.bindData(messagesView, at: indexPath)

		let rcmessage = messagesView.rcmessageAt(indexPath)

		viewBubble.backgroundColor = rcmessage.incoming ? RCKit.locationBubbleColorIncoming : RCKit.locationBubbleColorOutgoing

		if (imageViewThumb == nil) {
			imageViewThumb = UIImageView()
			imageViewThumb.layer.masksToBounds = true
			imageViewThumb.layer.cornerRadius = RCKit.bubbleRadius
			viewBubble.addSubview(imageViewThumb)
		}

		if (activityIndicator == nil) {
			if #available(iOS 13.0, *) {
				activityIndicator = UIActivityIndicatorView(style: .large)
			} else {
				activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
			}
			viewBubble.addSubview(activityIndicator)
		}

		if (rcmessage.mediaStatus == MediaStatus.Loading) {
			imageViewThumb.image = nil
			activityIndicator.startAnimating()
		}

		if (rcmessage.mediaStatus == MediaStatus.Succeed) {
			imageViewThumb.image = rcmessage.locationThumbnail
			activityIndicator.stopAnimating()
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func layoutSubviews() {

		let size = RCLocationCell.size(messagesView, at: indexPath)

		super.layoutSubviews(size)

		imageViewThumb.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

		let widthActivity = activityIndicator.frame.size.width
		let heightActivity = activityIndicator.frame.size.height
		let xActivity = (size.width - widthActivity) / 2
		let yActivity = (size.height - heightActivity) / 2
		activityIndicator.frame = CGRect(x: xActivity, y: yActivity, width: widthActivity, height: heightActivity)
	}

	//.devMARK: - Size methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func height(_ messagesView: RCMessagesView, at indexPath: IndexPath) -> CGFloat {

		let size = self.size(messagesView, at: indexPath)
		return size.height
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func size(_ messagesView: RCMessagesView, at indexPath: IndexPath) -> CGSize {

		return CGSize(width: RCKit.locationBubbleWidth, height: RCKit.locationBubbleHeight)
	}
}

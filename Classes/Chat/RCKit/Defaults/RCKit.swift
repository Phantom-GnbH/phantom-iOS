//

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
enum RCKit {

	//.devGeneral
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var widthScreen					= UIScreen.main.bounds.size.width
	static var heightScreen					= UIScreen.main.bounds.size.height

	//.devSection
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var sectionHeaderMargin			= CGFloat(8)
	static var sectionFooterMargin			= CGFloat(8)

	//.devHeader upper
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var headerUpperHeight			= CGFloat(20)
	static var headerUpperLeft				= CGFloat(10)
	static var headerUpperRight				= CGFloat(10)

	static var headerUpperColor				= UIColor.lightGray
	static var headerUpperFont				= UIFont.systemFont(ofSize: 12)

	//.devHeader lower
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var headerLowerHeight			= CGFloat(15)
	static var headerLowerLeft				= CGFloat(50)
	static var headerLowerRight				= CGFloat(50)

	static var headerLowerColor				= UIColor.lightGray
	static var headerLowerFont				= UIFont.systemFont(ofSize: 12)

	//.devFooter upper
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var footerUpperHeight			= CGFloat(15)
	static var footerUpperLeft				= CGFloat(50)
	static var footerUpperRight				= CGFloat(50)

	static var footerUpperColor				= UIColor.lightGray
	static var footerUpperFont				= UIFont.systemFont(ofSize: 12)

	//.devFooter lower
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var footerLowerHeight			= CGFloat(15)
	static var footerLowerLeft				= CGFloat(10)
	static var footerLowerRight				= CGFloat(10)

	static var footerLowerColor				= UIColor.lightGray
	static var footerLowerFont				= UIFont.systemFont(ofSize: 12)

	//.devBubble
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var bubbleMarginLeft				= CGFloat(40)
	static var bubbleMarginRight			= CGFloat(40)
	static var bubbleRadius					= CGFloat(15)

	//.devAvatar
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var avatarDiameter				= CGFloat(30)
	static var avatarMarginLeft				= CGFloat(5)
	static var avatarMarginRight			= CGFloat(5)

	static var avatarBackColor				= UIColor.lightGray
	static var avatarTextColor				= UIColor.white

	static var avatarFont					= UIFont.systemFont(ofSize: 12)

	//.devText cell
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var textBubbleWidthMax			= 0.70 * widthScreen
	static var textBubbleWidthMin			= CGFloat(45)
	static var textBubbleHeightMin			= CGFloat(35)

	static var textBubbleColorOutgoing		= UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
	static var textBubbleColorIncoming		= UIColor(red: 230/255, green: 229/255, blue: 234/255, alpha: 1.0)

	static var textTextColorOutgoing		= UIColor.white
	static var textTextColorIncoming		= UIColor.black

	static var textFont						= UIFont.systemFont(ofSize: 16)

	static var textInsetLeft				= CGFloat(10)
	static var textInsetRight				= CGFloat(10)
	static var textInsetTop					= CGFloat(10)
	static var textInsetBottom				= CGFloat(10)

	static var textInset = UIEdgeInsets.init(top: textInsetTop, left: textInsetLeft, bottom: textInsetBottom, right: textInsetRight)

	//.devEmoji cell
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var emojiBubbleWidthMax			= 0.70 * widthScreen
	static var emojiBubbleWidthMin			= CGFloat(45)
	static var emojiBubbleHeightMin			= CGFloat(30)

	static var emojiBubbleColorOutgoing		= UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
	static var emojiBubbleColorIncoming		= UIColor(red: 230/255, green: 229/255, blue: 234/255, alpha: 1.0)

	static var emojiFont					= UIFont.systemFont(ofSize: 46)

	static var emojiInsetLeft				= CGFloat(10)
	static var emojiInsetRight				= CGFloat(10)
	static var emojiInsetTop				= CGFloat(10)
	static var emojiInsetBottom				= CGFloat(10)

	static var emojiInset = UIEdgeInsets.init(top: emojiInsetTop, left: emojiInsetLeft, bottom: emojiInsetBottom, right: emojiInsetRight)

	//.devPhoto cell
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var photoBubbleWidth				= 0.70 * widthScreen

	static var photoBubbleColorOutgoing		= UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
	static var photoBubbleColorIncoming		= UIColor(red: 230/255, green: 229/255, blue: 234/255, alpha: 1.0)

	static var photoImageManual				= UIImage(named: "rckit_manual")!

	//.devVideo cell
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var videoBubbleWidth				= 0.70 * widthScreen
	static var videoBubbleHeight			= 0.70 * widthScreen

	static var videoBubbleColorOutgoing		= UIColor.lightGray
	static var videoBubbleColorIncoming		= UIColor.lightGray

	static var videoImagePlay				= UIImage(named: "rckit_videoplay")!
	static var videoImageManual				= UIImage(named: "rckit_manual")!

	//.devAudio cell
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var audioBubbleWidht				= CGFloat(150)
	static var audioBubbleHeight			= CGFloat(40)

	static var audioBubbleColorOutgoing		= UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
	static var audioBubbleColorIncoming		= UIColor(red: 230/255, green: 229/255, blue: 234/255, alpha: 1.0)

	static var audioTrackColorOutgoing		= UIColor.white
	static var audioTrackColorIncoming		= UIColor.white
	static var audioProgressColorOutgoing	= UIColor.lightGray
	static var audioProgressColorIncoming	= UIColor.lightGray

	static var audioDurationColorOutgoing	= UIColor.white
	static var audioDurationColorIncoming	= UIColor.black

	static var audioImagePlay				= UIImage(named: "rckit_audioplay")!
	static var audioImagePause				= UIImage(named: "rckit_audiopause")!
	static var audioImageManual				= UIImage(named: "rckit_manual")!

	static var audioFont					= UIFont.systemFont(ofSize: 12)

	//.devSticker cell
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var stickerBubbleWidth			= 0.70 * widthScreen
	static var stickerBubbleHeight			= 0.70 * widthScreen

	static var stickerBubbleColorOutgoing	= UIColor.clear
	static var stickerBubbleColorIncoming	= UIColor.clear

	static var stickerImageManual			= UIImage(named: "rckit_manual")!

	//.devLocation cell
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var locationBubbleWidth			= 0.70 * widthScreen
	static var locationBubbleHeight 		= 0.70 * widthScreen

	static var locationBubbleColorOutgoing	= UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
	static var locationBubbleColorIncoming	= UIColor(red: 230/255, green: 229/255, blue: 234/255, alpha: 1.0)

	//.devActivity indicator
	//-------------------------------------------------------------------------------------------------------------------------------------------
	static var activityColorOutgoing		= UIColor.white
	static var activityColorIncoming		= UIColor.darkGray
}

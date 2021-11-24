//

import WebKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class PrivacyView: UIViewController {

	@IBOutlet private var webView: WKWebView!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Privacy Policy"
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewWillAppear(_ animated: Bool) {

		super.viewWillAppear(animated)

		let path = Dir.application("privacy.html")
		webView.load(URLRequest(url: URL(fileURLWithPath: path)))
	}
}

//

import WebKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class TermsView: UIViewController {

	@IBOutlet private var webView: WKWebView!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Terms of Service"
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewWillAppear(_ animated: Bool) {

		super.viewWillAppear(animated)

		let path = Dir.application("terms.html")
		webView.load(URLRequest(url: URL(fileURLWithPath: path)))
	}
}

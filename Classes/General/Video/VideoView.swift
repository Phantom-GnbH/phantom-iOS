//

import AVKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class VideoView: UIViewController {

	private var url: URL!
	private var controller: AVPlayerViewController?

	//-------------------------------------------------------------------------------------------------------------------------------------------
	init(url: URL) {

		super.init(nibName: nil, bundle: nil)

		self.url = url

		self.isModalInPresentation = true
		self.modalPresentationStyle = .fullScreen
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	init(path: String) {

		super.init(nibName: nil, bundle: nil)

		self.url = URL(fileURLWithPath: path)

		self.isModalInPresentation = true
		self.modalPresentationStyle = .fullScreen
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	required init?(coder: NSCoder) {

		super.init(coder: coder)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()

		NotificationCenter.addObserver(self, selector: #selector(actionDone), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewWillAppear(_ animated: Bool) {

		super.viewWillAppear(animated)

		try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: .default, options: .defaultToSpeaker)

		controller = AVPlayerViewController()
		controller?.player = AVPlayer(url: url)
		controller?.player?.play()

		if (controller != nil) {
			addChild(controller!)
			view.addSubview(controller!.view)
			controller!.view.frame = view.frame
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewWillDisappear(_ animated: Bool) {

		super.viewWillDisappear(animated)

		NotificationCenter.removeObserver(self)
	}

	//.devMARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionDone() {

		dismiss(animated: true)
	}
}

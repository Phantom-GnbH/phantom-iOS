//

import UIKit
import AVFoundation

//-----------------------------------------------------------------------------------------------------------------------------------------------
@objc protocol AudioDelegate: AnyObject {

	func didRecordAudio(path: String)
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
class AudioView: UIViewController {

	@IBOutlet weak var delegate: AudioDelegate?

	@IBOutlet private var labelTimer: UILabel!
	@IBOutlet private var buttonRecord: UIButton!
	@IBOutlet private var buttonStop: UIButton!
	@IBOutlet private var buttonDelete: UIButton!
	@IBOutlet private var buttonPlay: UIButton!
	@IBOutlet private var buttonSend: UIButton!

	private var isPlaying = false
	private var isRecorded = false
	private var isRecording = false

	private var timer: Timer?
	private var dateTimer: Date?

	private var audioPlayer: AVAudioPlayer?
	private var audioRecorder: AVAudioRecorder?

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Audio"

		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(actionDismiss))

		updateButtonDetails()
	}

	//.devMARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionDismiss() {

		actionStop(0)

		dismiss(animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionRecord(_ sender: Any) {

		audioRecorderStart()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionStop(_ sender: Any) {

		if (isPlaying)		{ audioPlayerStop()		}
		if (isRecording)	{ audioRecorderStop()	}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionDelete(_ sender: Any) {

		isRecorded = false
		updateButtonDetails()

		timerReset()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionPlay(_ sender: Any) {

		audioPlayerStart()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionSend(_ sender: Any) {

		dismiss(animated: true)

		if let path = audioRecorder?.url.path {
			delegate?.didRecordAudio(path: path)
		}
	}

	//.devMARK: - Audio recorder methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func audioRecorderStart() {

		isRecording = true
		updateButtonDetails()

		timerStart()

		try? AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, policy: .default, options: .defaultToSpeaker)

		let settings = [AVFormatIDKey: kAudioFormatMPEG4AAC, AVSampleRateKey: 44100, AVNumberOfChannelsKey: 2]
		audioRecorder = try? AVAudioRecorder(url: URL(fileURLWithPath: File.temp("m4a")), settings: settings)
		audioRecorder?.prepareToRecord()
		audioRecorder?.record()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func audioRecorderStop() {

		isRecording = false
		isRecorded = true
		updateButtonDetails()

		timerStop()

		audioRecorder?.stop()
	}

	//.devMARK: - Audio player methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func audioPlayerStart() {

		isPlaying = true
		updateButtonDetails()

		timerStart()

		try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: .default, options: .defaultToSpeaker)

		if let url = audioRecorder?.url {
			audioPlayer = try? AVAudioPlayer(contentsOf: url)
			audioPlayer?.delegate = self
			audioPlayer?.prepareToPlay()
			audioPlayer?.play()
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func audioPlayerStop() {

		isPlaying = false
		updateButtonDetails()

		timerStop()

		audioPlayer?.stop()
	}

	//.devMARK: - Timer methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func timerStart() {

		dateTimer = Date()

		timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { _ in
			self.timerUpdate()
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func timerUpdate() {

		if (dateTimer != nil) {
			let interval = Date().timeIntervalSince(dateTimer!)
			let millisec = Int(interval * 100) % 100
			let seconds = Int(interval) % 60
			let minutes = Int(interval) / 60
			labelTimer.text = String(format: "%02d:%02d:%02d", minutes, seconds, millisec)
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func timerStop() {

		timer?.invalidate()
		timer = nil
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func timerReset() {

		labelTimer.text = "00:00:00"
	}

	//.devMARK: - Helper methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func updateButtonDetails() {

		buttonRecord.isHidden	= isRecorded
		buttonStop.isHidden		= (isPlaying == false) && (isRecording == false)
		buttonDelete.isHidden	= (isPlaying == true) || (isRecorded == false)
		buttonPlay.isHidden		= (isPlaying == true) || (isRecorded == false)
		buttonSend.isHidden		= (isPlaying == true) || (isRecorded == false)
	}
}

//.devMARK: - AVAudioPlayerDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension AudioView: AVAudioPlayerDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {

		isPlaying = false
		updateButtonDetails()

		timerStop()
	}
}

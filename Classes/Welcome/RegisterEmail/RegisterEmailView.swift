//

import UIKit
import ProgressHUD
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
@objc protocol RegisterEmailDelegate: AnyObject {

	func didRegisterUser()
}

//-----------------------------------------------------------------------------------------------------------------------------------------------
class RegisterEmailView: UIViewController {

	@IBOutlet weak var delegate: RegisterEmailDelegate?

	@IBOutlet private var fieldEmail: UITextField!
	@IBOutlet private var fieldPassword: UITextField!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()

		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(gestureRecognizer)
		gestureRecognizer.cancelsTouchesInView = false
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewWillDisappear(_ animated: Bool) {

		super.viewWillDisappear(animated)

		dismissKeyboard()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func dismissKeyboard() {

		view.endEditing(true)
	}

	//.devMARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionDismiss(_ sender: Any) {

		dismiss(animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionRegister(_ sender: Any) {

		let email = (fieldEmail.text ?? "").lowercased()
		let password = fieldPassword.text ?? ""

		if (email.isEmpty)		{ ProgressHUD.showFailed("Please enter your email.");		return }
		if (password.isEmpty)	{ ProgressHUD.showFailed("Please enter your password.");	return }

		actionRegister(email, password)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func actionRegister(_ email: String, _ password: String) {

		ProgressHUD.show(nil, interaction: false)

		GQLAuth.signUp(email: email, password: password) { error in
			if let error = error {
				ProgressHUD.showFailed(error.localizedDescription)
			} else {
				self.createUser(email)
			}
		}
	}

	//.devMARK: -
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func createUser(_ email: String) {

		let userId = GQLAuth.userId()
		DBUsers.create(userId, email)

		DispatchQueue.main.async {
			self.loginSucceed()
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func loginSucceed() {

		dismiss(animated: true) {
			self.delegate?.didRegisterUser()
		}
	}
}

//.devMARK: - UITextFieldDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension RegisterEmailView: UITextFieldDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {

		if (textField == fieldEmail) {
			fieldPassword.becomeFirstResponder()
		}
		if (textField == fieldPassword) {
			actionRegister(0)
		}
		return true
	}
}

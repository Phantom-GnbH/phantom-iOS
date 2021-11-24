//

import UIKit
import ProgressHUD
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class PasswordView: UIViewController {

	@IBOutlet private var tableView: UITableView!
	@IBOutlet private var cellPassword0: UITableViewCell!
	@IBOutlet private var cellPassword1: UITableViewCell!
	@IBOutlet private var cellPassword2: UITableViewCell!
	@IBOutlet private var fieldPassword0: UITextField!
	@IBOutlet private var fieldPassword1: UITextField!
	@IBOutlet private var fieldPassword2: UITextField!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Change Password"

		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(actionDismiss))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(actionDone))

		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tableView.addGestureRecognizer(gestureRecognizer)
		gestureRecognizer.cancelsTouchesInView = false
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidAppear(_ animated: Bool) {

		super.viewDidAppear(animated)

		fieldPassword0.becomeFirstResponder()
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

	//.devMARK: - Backend actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func checkPassword() {

		let password = fieldPassword0.text ?? ""

		ProgressHUD.show(nil, interaction: false)
		GQLAuth.checkPassword(password: password) { error in
			if let error = error {
				ProgressHUD.showFailed(error.localizedDescription)
			} else {
				DispatchQueue.main.async {
					self.updatePassword()
				}
			}
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func updatePassword() {

		let password = fieldPassword1.text ?? ""

		GQLAuth.updatePassword(password: password) { error in
			if let error = error {
				ProgressHUD.showFailed(error.localizedDescription)
			} else {
				ProgressHUD.showSucceed("Password changed.")
				DispatchQueue.main.async {
					self.dismiss(animated: true)
				}
			}
		}
	}

	//.devMARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionDismiss() {

		dismiss(animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionDone() {

		let password0 = fieldPassword0.text ?? ""
		let password1 = fieldPassword1.text ?? ""
		let password2 = fieldPassword2.text ?? ""

		if (password0.isEmpty)		{ ProgressHUD.showFailed("Current Password must be set.");		return	}
		if (password1.isEmpty)		{ ProgressHUD.showFailed("New Password must be set.");			return	}
		if (password1 != password2)	{ ProgressHUD.showFailed("New Passwords must be the same.");	return	}

		checkPassword()
	}
}

//.devMARK: - UITableViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension PasswordView: UITableViewDataSource {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfSections(in tableView: UITableView) -> Int {

		return 2
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if (section == 0) { return 1 }
		if (section == 1) { return 2 }

		return 0
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		if (indexPath.section == 0) && (indexPath.row == 0) { return cellPassword0	}
		if (indexPath.section == 1) && (indexPath.row == 0) { return cellPassword1	}
		if (indexPath.section == 1) && (indexPath.row == 1) { return cellPassword2	}

		return UITableViewCell()
	}
}

//.devMARK: - UITableViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension PasswordView: UITableViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)
	}
}

//.devMARK: - UITextFieldDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension PasswordView: UITextFieldDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {

		if (textField == fieldPassword0) { fieldPassword1.becomeFirstResponder()	}
		if (textField == fieldPassword1) { fieldPassword2.becomeFirstResponder()	}
		if (textField == fieldPassword2) { actionDone()								}

		return true
	}
}

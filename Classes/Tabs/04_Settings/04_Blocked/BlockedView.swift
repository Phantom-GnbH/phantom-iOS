//

import UIKit
import GraphQLite

//-----------------------------------------------------------------------------------------------------------------------------------------------
class BlockedView: UIViewController {

	@IBOutlet private var searchBar: UISearchBar!
	@IBOutlet private var tableView: UITableView!

	private var dbusers: [DBUser] = []

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Blocked Users"

		navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)

		tableView.register(UINib(nibName: "BlockedCell", bundle: nil), forCellReuseIdentifier: "BlockedCell")

		tableView.tableFooterView = UIView()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewWillAppear(_ animated: Bool) {

		super.viewWillAppear(animated)

		loadUsers()
	}

	//.devMARK: - Database methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func loadUsers() {

		dbusers.removeAll()

		let text = searchBar.text ?? ""

		let arguments: [String: Any] = [":userId": GQLAuth.userId(), ":true": true, ":false": false, ":text": "%%\(text)%%"]

		let condition = "objectId IN (SELECT userId2 FROM DBRelation WHERE userId1 = :userId AND isBlocked = :true) AND fullname LIKE :text"

		dbusers = DBUser.fetchAll(gqldb, condition, arguments, order: "fullname")

		tableView.reloadData()
	}
}

//.devMARK: - UIScrollViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension BlockedView: UIScrollViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

		view.endEditing(true)
	}
}

//.devMARK: - UITableViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension BlockedView: UITableViewDataSource {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfSections(in tableView: UITableView) -> Int {

		return 1
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return dbusers.count
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "BlockedCell", for: indexPath) as! BlockedCell

		let dbuser = dbusers[indexPath.row]
		cell.bindData(dbuser)
		cell.loadImage(dbuser)

		return cell
	}
}

//.devMARK: - UITableViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension BlockedView: UITableViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		tableView.deselectRow(at: indexPath, animated: true)

		let dbuser = dbusers[indexPath.row]
		let profileView = ProfileView(dbuser.objectId, chat: true)
		navigationController?.pushViewController(profileView, animated: true)
	}
}

//.devMARK: - UISearchBarDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension BlockedView: UISearchBarDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

		loadUsers()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

		searchBar.setShowsCancelButton(true, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

		searchBar.setShowsCancelButton(false, animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

		searchBar.text = ""
		searchBar.resignFirstResponder()
		loadUsers()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

		searchBar.resignFirstResponder()
	}
}

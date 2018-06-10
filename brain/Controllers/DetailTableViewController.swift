import UIKit

class DetailTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!

  var item: Item?

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.registerCell(DetailTableViewCell.self)
    tableView.registerCell(DetailHeaderTableViewCell.self)
    tableView.allowsSelection = false
    view.backgroundColor = .defaultBackground
    tableView.backgroundColor = .defaultBackground
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    guard let _ = item else { return 0 }
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 1 {
      return 1
    } else {
      guard let rows = item?.authorList.count else { return 0 }
      return rows
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderTableViewCell.identifier, for: indexPath) as! DetailHeaderTableViewCell
      cell.present(item: item)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
      cell.present(author: item?.authorList[indexPath.row])
      return cell
    }
  }
}

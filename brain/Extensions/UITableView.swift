import UIKit

extension UITableView {
  func registerCell(_ cell: UITableViewCell.Type) {
    self.register(cell.nib, forCellReuseIdentifier: cell.identifier)
  }
}

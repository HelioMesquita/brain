import UIKit

class DetailTableViewCell: UITableViewCell {

  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var authordescriptionLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = .defaultBackground
  }

  func present(author: Author?) {
    authorLabel.text = author?.name
    authordescriptionLabel.text = author?.description
  }
}

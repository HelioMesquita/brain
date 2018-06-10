import UIKit

class MainTableViewCell: UITableViewCell {

  @IBOutlet weak var photoImg: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = .defaultBackground
  }

  func present(item: Item?) {
    photoImg.setImageFrom(url: item?.imageUrl)
    titleLabel.text = item?.title
    subtitleLabel.text = item?.subtitle
    authorLabel.text = item?.authorsName()
  }
}

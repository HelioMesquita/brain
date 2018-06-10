import UIKit

class DetailHeaderTableViewCell: UITableViewCell {

  @IBOutlet weak var photoImg: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var aboutAuthorLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = .defaultBackground
  }

  func present(item: Item?) {
    photoImg.setImageFrom(url: item?.authorList.first?.imageUrl)
    titleLabel.text = item?.title
    subtitleLabel.text = item?.subtitle
    descriptionLabel.text = item?.description
    aboutAuthorLabel.text = item?.aboutAuthorLabel()
  }
}

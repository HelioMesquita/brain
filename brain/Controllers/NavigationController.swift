import UIKit

class NavigationController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.barTintColor = UIColor.white
    navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19, weight: .regular)]
  }
}

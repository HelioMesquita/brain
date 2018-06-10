import UIKit

extension UIView {

  static func instanceFromNib<T>() -> T {
    return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! T
  }
}

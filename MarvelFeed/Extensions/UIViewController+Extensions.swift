import UIKit

extension UIViewController {
  func showAlert(title: String, message: String, handler: @escaping (UIAlertAction) -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: handler))

    present(alert, animated: true, completion: nil)
  }
}

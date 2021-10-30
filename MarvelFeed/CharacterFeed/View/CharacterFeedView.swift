import UIKit

final class CharacterFeedView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(viewModel: CharacterFeedViewModel) {

  }

  private func setUpView() {
    backgroundColor = .black
  }
}

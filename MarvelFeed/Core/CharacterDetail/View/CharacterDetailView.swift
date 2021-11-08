import UIKit
import Kingfisher

final class CharacterDetailView: UIView {
  var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 20
    return imageView
  }()

  var nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor(named: Constants.feedTextColor)
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.textAlignment = .left
    return label
  }()

  var descriptionLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor(named: Constants.feedTextColor)
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()

  override func layoutSubviews() {
    setupView()
  }

  func configure(viewModel: CharacterViewModel) {
    nameLabel.text = viewModel.name
    descriptionLabel.text = viewModel.description

    guard !viewModel.thumbnail.isEmpty else {
      if let image = UIImage(named: Constants.noAvatarImage) {
        imageView.image = image
      }
      return
    }

    // TODO: Create image downloader to avoid using dependency
    imageView.kf.setImage(with: URL(string: viewModel.thumbnail))
  }

  private func setupView() {
    let stackView = makeVerticalStack(subviews: [imageView, nameLabel, descriptionLabel])

    addSubview(stackView)
    imageView.heightAnchor.constraint(equalToConstant: frame.width).isActive = true
    stackView.anchor(
      top: layoutMarginsGuide.topAnchor,
      paddingTop: 20,
      left: leadingAnchor,
      paddingLeft: 20,
      right: trailingAnchor,
      paddingRight: 20
    )

    backgroundColor = UIColor(named: Constants.feedBackgroundColor)
  }

  private func makeVerticalStack(subviews: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: subviews)
    stackView.axis = .vertical
    stackView.spacing = 20
    return stackView
  }
}

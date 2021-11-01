import UIKit

final class CharacterDetailView: UIView {
  var imageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "heroTemp"))
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 20
    return imageView
  }()

  var nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.textAlignment = .left
    return label
  }()

  var descriptionLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()

  override func layoutSubviews() {
    setUpView()
  }

  private func setUpView() {
    let stackView = makeVerticalStack(subviews: [imageView, nameLabel, descriptionLabel])
    nameLabel.text = "Dave"
    descriptionLabel.text = "init(coder:) has not been implemented init(coder:) has not been implemented"

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

    self.backgroundColor = .white
  }

  private func makeVerticalStack(subviews: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: subviews)
    stackView.axis = .vertical
    stackView.spacing = 20
    return stackView
  }
}

import UIKit
import Kingfisher

final class CharacterFeedCell: UITableViewCell {
  var nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.textAlignment = .left
    return label
  }()

  var descriptionLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()

  var characterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 20
    return imageView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    let leftStackView = makeVerticalStack(subviews: [nameLabel, descriptionLabel])
    let horizontalStackView = makeHorizontalStack(subviews: [leftStackView, characterImageView])

    characterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    characterImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    addSubview(horizontalStackView)

    horizontalStackView.anchor(
      top: topAnchor,
      paddingTop: 20,
      left: leadingAnchor,
      paddingLeft: 20,
      bottom: bottomAnchor,
      paddingBottom: 20,
      right: trailingAnchor,
      paddingRight: 20
    )
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func makeVerticalStack(subviews: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: subviews)
    stackView.axis = .vertical
    stackView.spacing = 8

    return stackView
  }

  private func makeHorizontalStack(subviews: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: subviews)
    stackView.axis = .horizontal
    stackView.distribution = .fillProportionally
    stackView.spacing = 8
    stackView.alignment = .top

    return stackView
  }
}

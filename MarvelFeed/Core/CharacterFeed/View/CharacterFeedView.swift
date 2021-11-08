import UIKit

final class CharacterFeedView: UIView {
  lazy var coverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Cover")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  lazy var searchBar: UISearchBar = {
    UISearchBar()
  }()

  lazy var tableView: UITableView = {
    UITableView()
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(
    viewModel: CharacterFeedViewModel,
    delegate: UITableViewDelegate,
    dataSource: UITableViewDataSource,
    searchBarDelegate: UISearchBarDelegate) {
      tableView.delegate = delegate
      tableView.dataSource = dataSource
      tableView.register(CharacterFeedCell.self, forCellReuseIdentifier: CharacterFeedCell.id)
      searchBar.delegate = searchBarDelegate
    }

  private func setupView() {
    backgroundColor = .white

    addSubview(coverImageView)
    coverImageView.anchor(top: layoutMarginsGuide.topAnchor, left: leadingAnchor, right: trailingAnchor, height: 160)

    addSubview(searchBar)
    searchBar.anchor(top: coverImageView.bottomAnchor, left: leadingAnchor, right: trailingAnchor)

    addSubview(tableView)
    tableView.anchor(top: searchBar.bottomAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor)
  }
}

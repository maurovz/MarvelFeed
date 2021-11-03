import UIKit

final class CharacterFeedView: UIView {
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    return searchBar
  }()

  lazy var tableView: UITableView = {
    UITableView()
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
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
      searchBar.delegate = searchBarDelegate
    }

  private func setUpView() {
    backgroundColor = .white

    addSubview(searchBar)
    searchBar.anchor(top: layoutMarginsGuide.topAnchor, left: leadingAnchor, right: trailingAnchor)

    addSubview(tableView)
    tableView.anchor(top: searchBar.bottomAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor)
  }
}

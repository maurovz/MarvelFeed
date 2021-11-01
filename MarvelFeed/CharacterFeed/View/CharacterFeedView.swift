import UIKit

final class CharacterFeedView: UIView {
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

  func configure(viewModel: CharacterFeedViewModel, delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
    tableView.delegate = delegate
    tableView.dataSource = dataSource
  }

  private func setUpView() {
    addSubview(tableView)
    tableView.anchor(top: topAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor)
  }
}

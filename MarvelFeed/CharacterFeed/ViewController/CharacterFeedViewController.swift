import UIKit

final class CharacterFeedViewController: UIViewController {
  private let characterFeedViewModel: CharacterFeedViewModel
  private let characterFeedView = CharacterFeedView()
  private let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

  private lazy var retryButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    button.setTitle("Retry", for: .normal)
    button.setTitleColor(.black, for: .normal)
    return button
  }()

  public init(characterFeedViewModel: CharacterFeedViewModel) {
    self.characterFeedViewModel = characterFeedViewModel
    super.init(nibName: nil, bundle: Bundle(for: CharacterFeedViewController.self))
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupFeed()
  }

  public override func loadView() {
    view = characterFeedView
  }
}

// MARK: Private Methods

private extension CharacterFeedViewController {
  func setupFeed() {
    characterFeedView.tableView.register(CharacterFeedCell.self, forCellReuseIdentifier: "cellId")
    characterFeedView.configure(viewModel: characterFeedViewModel, delegate: self, dataSource: self, searchBarDelegate: self)
    characterFeedViewModel.delegate = self

    fetchCharacters()
  }

  func fetchCharacters() {
    view.addActivityIndicator(activityView: activityView)
    characterFeedViewModel.fetch()
  }

  func showRetryButton(_: UIAlertAction) {
    retryButton.addTarget(self, action: #selector(reloadFeed), for: .touchUpInside)
    view.addSubview(retryButton)
    retryButton.center(inView: view)
  }

  @objc func reloadFeed() {
    retryButton.removeFromSuperview()
    setupFeed()
  }
}

extension CharacterFeedViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    characterFeedViewModel.filteredCharacters.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // swiftlint:disable force_cast
    let cell = characterFeedView.tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CharacterFeedCell
    let character = characterFeedViewModel.filteredCharacters[indexPath.row]

    cell.nameLabel.text = character.name
    cell.descriptionLabel.text = character.description

    let url = URL(string: character.thumbnail)
    cell.characterImageView.kf.setImage(with: url)

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    characterFeedViewModel.didSelectAction(characterFeedViewModel.filteredCharacters[indexPath.row])
  }
}

extension CharacterFeedViewController: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.showsCancelButton = false
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard searchText != "" else {
      characterFeedViewModel.resetFilter()
      characterFeedView.tableView.reloadData()
      return
    }

    characterFeedViewModel.filterResults(value: searchText)
    characterFeedView.tableView.reloadData()
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.showsCancelButton = false
  }
}

extension CharacterFeedViewController: CharacterFeedProtocol {
  func showError(message: String) {
    DispatchQueue.main.async {
      self.activityView.removeFromSuperview()
      self.showAlert(title: "Localized Title", message: message, handler: self.showRetryButton)
    }
  }

  func didLoadData() {
    DispatchQueue.main.async {
      self.activityView.removeFromSuperview()
      self.characterFeedView.tableView.reloadData()
    }
  }
}

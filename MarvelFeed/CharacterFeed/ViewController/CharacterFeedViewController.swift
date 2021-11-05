import UIKit

final class CharacterFeedViewController: UIViewController {
  private let characterFeedViewModel: CharacterFeedViewModel
  private let characterView = CharacterFeedView()
  private let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

  public init(characterFeedViewModel: CharacterFeedViewModel) {
    self.characterFeedViewModel = characterFeedViewModel
    super.init(nibName: nil, bundle: Bundle(for: CharacterFeedViewController.self))
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    characterView.tableView.register(CharacterFeedCell.self, forCellReuseIdentifier: "cellId")
    characterView.configure(viewModel: characterFeedViewModel, delegate: self, dataSource: self, searchBarDelegate: self)

    fetchCharacters()
  }

  public override func loadView() {
    view = characterView
  }

  private func fetchCharacters() {
    view.addActivityIndicator(activityView: activityView)

    characterFeedViewModel.fetch()

    characterFeedViewModel.onFetch = { _ in
      DispatchQueue.main.async {
        self.activityView.removeFromSuperview()
        self.characterView.tableView.reloadData()
      }
    }
  }
}

extension CharacterFeedViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    characterFeedViewModel.filteredCharacters.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // swiftlint:disable force_cast
    let cell = characterView.tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CharacterFeedCell
    let character = characterFeedViewModel.filteredCharacters[indexPath.row]

    cell.nameLabel.text = character.name
    cell.descriptionLabel.text = character.description

    let url = URL(string: character.thumbnail)
    cell.characterImageView.kf.setImage(with: url)

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    characterFeedViewModel.didSelect(characterFeedViewModel.filteredCharacters[indexPath.row])
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
      characterView.tableView.reloadData()
      return
    }

    characterFeedViewModel.filterResults(value: searchText)
    characterView.tableView.reloadData()
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.showsCancelButton = false
  }
}

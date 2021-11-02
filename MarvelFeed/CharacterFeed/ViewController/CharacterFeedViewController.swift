import UIKit

final class CharacterFeedViewController: UIViewController {
  private let characterFeedViewModel: CharacterFeedViewModel
  private let characterView = CharacterFeedView()

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
    characterView.configure(viewModel: characterFeedViewModel, delegate: self, dataSource: self)

    fetchCharacters()
  }

  public override func loadView() {
    view = characterView
  }

  private func fetchCharacters() {
    characterFeedViewModel.fetch()

    characterFeedViewModel.onFetch = { characters in
      DispatchQueue.main.async {
        self.characterFeedViewModel.characters = characters
        self.characterView.tableView.reloadData()
      }
    }
  }
}

extension CharacterFeedViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    characterFeedViewModel.characters.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // swiftlint:disable force_cast
    let cell = characterView.tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CharacterFeedCell
    let character = characterFeedViewModel.characters[indexPath.row]

    cell.nameLabel.text = character.name
    cell.descriptionLabel.text = character.description

    let url = URL(string: character.thumbnail)
    cell.characterImageView.kf.setImage(with: url)

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    characterFeedViewModel.didSelect(characterFeedViewModel.characters[indexPath.row])
  }
}

import UIKit

class CharacterFeedViewController: UIViewController {
  private let characterFeedViewModel: CharacterFeedViewModel
  private var characters: [CharacterViewModel] = []
  private var characterView = CharacterFeedView()

  public init(characterFeedViewModel: CharacterFeedViewModel) {
    self.characterFeedViewModel = characterFeedViewModel
    super.init(nibName: nil, bundle: Bundle(for: CharacterFeedViewController.self))
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

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
        self.characters = characters
        self.characterView.tableView.reloadData()
      }
    }
  }
}

extension CharacterFeedViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    characters.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
    cell.textLabel?.text = characters[indexPath.row].name
    return cell
  }
}

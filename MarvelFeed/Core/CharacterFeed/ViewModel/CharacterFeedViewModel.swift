import FeedFeature

protocol CharacterFeedProtocol: AnyObject {
  func showError(message: String)
  func didLoadData()
}

final class CharacterFeedViewModel {
  typealias SelectionAction = (CharacterViewModel) -> Void?

  private let loader: CharacterLoader
  private var characters: [CharacterViewModel] = []

  public weak var delegate: CharacterFeedProtocol?

  public var didSelectAction: SelectionAction
  public var filteredCharacters: [CharacterViewModel] = []

  public init(loader: CharacterLoader, didSelectAction: @escaping SelectionAction) {
    self.loader = loader
    self.didSelectAction = didSelectAction
  }

  public func fetch() {
    loader.load { [weak self] result in
      guard let self = self else { return }

      switch result {
        case .success(let characters):
          self.setCharacters(characters)
          self.delegate?.didLoadData()

        case .failure(let error):
          self.delegate?.showError(message: error.localizedDescription)
      }
    }
  }

  public func filterResults(value: String) {
    filteredCharacters = characters.filter { $0.name.contains(value) }
  }

  public func resetFilter() {
    filteredCharacters =  characters
  }

  private func setCharacters(_ value: [Character]) {
    let mappedCharacters = value.map { CharacterViewModel(character: $0) }
    characters = mappedCharacters
    filteredCharacters = characters
  }
}

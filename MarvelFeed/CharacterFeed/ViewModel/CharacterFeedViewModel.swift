import FeedFeature

class CharacterFeedViewModel {
  private let loader: CharacterLoader
  private var characters: [CharacterViewModel] = []

  public var onFetch: (([CharacterViewModel]) -> Void)?
  public var didSelect: (CharacterViewModel) -> Void?
  public var filteredCharacters: [CharacterViewModel] = []

  public init(loader: CharacterLoader, didSelect: @escaping (CharacterViewModel) -> Void?) {
    self.loader = loader
    self.didSelect = didSelect
  }

  public func fetch() {
    loader.load { [weak self] result in
      guard let self = self else { return }

      switch result {
        case .success(let characters):
          let mappedCharacters = characters.map { CharacterViewModel(character: $0) }
          self.onFetch?(mappedCharacters)
          self.characters = mappedCharacters
          self.filteredCharacters = mappedCharacters

        case .failure(let error):
          print("Networking Error!! \(error)")
      }
    }
  }

  public func filterResults(value: String) {
    filteredCharacters = characters.filter { $0.name.contains(value) }
  }

  public func resetFilter() {
    filteredCharacters =  characters
  }
}

import FeedFeature

class CharacterFeedViewModel {
  private let loader: CharacterLoader

  public init(loader: CharacterLoader, didSelect: @escaping (CharacterViewModel) -> Void?) {
    self.loader = loader
    self.didSelect = didSelect
  }

  public var onFetch: (([CharacterViewModel]) -> Void)?

  public var didSelect: (CharacterViewModel) -> Void?

  public func fetch() {
    loader.load { [weak self] result in
      guard let self = self else { return }

      switch result {
        case .success(let characters):
          self.onFetch?(characters.map { CharacterViewModel(character: $0) })

        case .failure(let error):
          print("Networking Error!! \(error)")
      }
    }
  }
}

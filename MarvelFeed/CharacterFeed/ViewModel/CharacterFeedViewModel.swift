import FeedFeature

class CharacterFeedViewModel {
  private let loader: CharacterLoader

  public init(loader: CharacterLoader) {
    self.loader = loader
  }

  public var onFetch: (([Character]) -> Void)?

  public func fetch() {
    loader.load { [weak self] result in
      guard let self = self else { return }

      switch result {
        case .success(let character):
          self.onFetch?(character)

        case .failure(let error):
          print("Networking Error!! \(error)")
      }
    }
  }
}
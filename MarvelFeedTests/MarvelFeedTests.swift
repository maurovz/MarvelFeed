import XCTest
import SnapshotTesting

@testable import FeedFeature
@testable import MarvelFeed

class MarvelFeedSnapshotTests: XCTestCase {

  /*
   // NOTE: Test only fails on Github Action flow.. Might need to switch to Travis

  func test_characterFeedView_with_snapshot() {
    let viewModel = CharacterFeedViewModel(loader: DummyCharacterLoader(), didSelectAction: { _ in })
    let viewController = CharacterFeedViewController(characterFeedViewModel: viewModel)
    viewController.loadViewIfNeeded()
    viewController.activityView.isHidden = true

    assertSnapshot(matching: viewController, as: .image(on: .iPhoneXr))
  }
 */

  func test_characterDetailView_with_snapshot() {
    let character = Character(name: "Silly Hero", description: "Not very smart, but very funny", thumbnail: "")
    let viewController = CharacterDetailViewController(viewModel: CharacterViewModel(character: character))

    assertSnapshot(matching: viewController, as: .image(on: .iPhoneXr))
  }

  private class DummyCharacterLoader: CharacterLoader {
    func load(completion: @escaping (CharacterLoader.Result) -> Void) {
      completion(.success([Character.prototypeCharacter]))
    }
  }
}

extension Character {
  static let prototypeCharacter = Character(name: "Silly Hero", description: "Not very smart, but very funny", thumbnail: "")
}

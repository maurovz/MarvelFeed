import XCTest
import SnapshotTesting

@testable import FeedFeature
@testable import MarvelFeed

class MarvelFeedSnapshotTests: XCTestCase {
  func test_characterDetailView_snapshot() {
    let character = Character(name: "Silly Hero", description: "Not very smart, but very funny", thumbnail: "")
    let viewController = CharacterDetailViewController(viewModel: CharacterViewModel(character: character))
    assertSnapshot(matching: viewController, as: .image(on: .iPhoneXr))
  }
}

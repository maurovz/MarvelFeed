import XCTest
import FeedFeature

class CharacterMapperTest: XCTestCase {
  func test_map_throwsErrorWithInvalidJSON() throws {
    let invalidJSON = Data("invalid json".utf8)

    XCTAssertThrowsError(try CharacterMapper.map(data: invalidJSON))
  }

  func test_map_deliversCharacterWithValidJSON() throws {
    let character = makeCharacter(name: "Hero Tester",
                             description: "A testing hero",
                             thumbnail: URL(string: "http://any-url.com")!,
                             comicName: "Testing Hero Comic 1",
                             comicDescription: "Testing Hero Chapter 1",
                             comicThumbnail: URL(string: "http://any-url.com")!)

    let result = try CharacterMapper.map(data: makeJSON(character.json))

    XCTAssertEqual(result, character.model)
  }
}

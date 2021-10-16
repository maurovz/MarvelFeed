import XCTest
import FeedFeature

class CharacterMapperTest: XCTestCase {
  func test_map_throwsErrorWithInvalidJSON() throws {
    let invalidJSON = Data("invalid json".utf8)

    XCTAssertThrowsError(try CharacterMapper.map(data: invalidJSON))
  }
}

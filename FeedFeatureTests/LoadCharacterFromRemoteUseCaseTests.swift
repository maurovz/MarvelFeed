import XCTest
import FeedFeature

class LoadCharacterFromRemoteUseCaseTests: XCTestCase {
  func test_init_doesNotRequestURL() {
    let (_, client) = makeSUT()

    XCTAssertEqual(client.requestedURLs, [], "Client should not request url on init")
  }

  private func makeSUT(with url: URL = URL(string: "http://any-url.com")!,
                       file: StaticString = #file,
                       line: UInt = #line) -> (sut: CharacterLoader, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let sut = RemoteCharacterLoader(url: url, client: client)

    return (sut, client)
  }
}

import XCTest
import FeedFeature

class LoadCharacterFromRemoteUseCaseTests: XCTestCase {
  func test_init_doesNotRequestURL() {
    let (_, client) = makeSUT()

    XCTAssertEqual(client.requestedURLs, [], "Client should not request url on init")
  }

  func test_load_requestsDataFromURL() {
    let url = URL(string: "http://any-url.com")!
    let (sut, client) = makeSUT(with: url)

    sut.load { _ in }

    XCTAssertEqual(client.requestedURLs, [url])
  }

  // MARK: - Helpers

  private func makeSUT(with url: URL = URL(string: "http://any-url.com")!,
                       file: StaticString = #file,
                       line: UInt = #line) -> (sut: RemoteCharacterLoader, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let sut = RemoteCharacterLoader(url: url, client: client)

    return (sut, client)
  }

  private func expect(_ sut: RemoteCharacterLoader, completesWith expectedResult: RemoteCharacterLoader.Result, when action: () -> Void) {
    let exp = expectation(description: "Wait for completion")

    sut.load { receivedResult in
      switch (receivedResult, expectedResult) {
      case let (.success(receivedItem), .success(expectedItem)):
        XCTAssertEqual(receivedItem, expectedItem)

      case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
        XCTAssertEqual(receivedError, expectedError)

      default:
        XCTFail("Expected result \(expectedResult) got \(receivedResult) instead")
      }

      exp.fulfill()
    }

    action()

    wait(for: [exp], timeout: 0.1)
  }
}

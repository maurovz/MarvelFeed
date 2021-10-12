import Foundation
import FeedFeature

final class HTTPClientSpy: HTTPClient {
  private struct Task: HTTPClientTask {
    let callback: () -> Void
    func cancel() { callback() }
  }

  private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()
  private(set) var cancelledURLs = [URL]()

  var requestedURLs: [URL] {
    return messages.map { $0.url }
  }

  func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
    messages.append((url, completion))
    return Task { [weak self] in
      self?.cancelledURLs.append(url)
    }
  }
}

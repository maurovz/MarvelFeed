import Foundation

public final class RemoteCharacterLoader: CharacterLoader {
  private let url: URL
  private let client: HTTPClient

  public init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }

  public typealias Result = CharacterLoader.Result

  public func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { result in
      switch result {
      case .success((let data, _)):
        print(data)

      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

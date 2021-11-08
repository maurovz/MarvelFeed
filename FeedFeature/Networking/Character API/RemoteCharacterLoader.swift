import Foundation

public final class RemoteCharacterLoader: CharacterLoader {
  private let url: URL
  private let client: HTTPClient
  private let cache: CoreDataServices

  public init(url: URL, client: HTTPClient, cache: CoreDataServices) {
    self.url = url
    self.client = client
    self.cache = cache
  }

  public typealias Result = CharacterLoader.Result

  public func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { result in
      switch result {
      case .success((let data, _)):
        guard let mappedCharacter = try? CharacterMapper.map(data: data) else {
          completion(.failure(CharacterMapper.Error.invalidData))
          return
        }

        self.setCache(characters: mappedCharacter)
        completion(.success(mappedCharacter))

      case .failure(let error):
        let cacheCharacters = self.cache.loadCharactersFromCoreData()
        guard !cacheCharacters.isEmpty else {
          completion(.failure(error))
          return
        }

        completion(.success(cacheCharacters))
      }
    }
  }

  private func setCache(characters: [Character]) {
    guard cache.deleteEntityFromCoreData(entity: "CharacterDescription") else { return }
    cache.saveCharactersToCache(characters: characters)
  }
}

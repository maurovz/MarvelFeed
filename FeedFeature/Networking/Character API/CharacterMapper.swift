public final class CharacterMapper {
  public enum Error: Swift.Error {
    case invalidData
  }

  private struct Root: Decodable {
    private let results: [RemoteCharacter]

    private struct RemoteCharacter: Decodable {
      private let name: String
      private let description: String
      private let thumbnail: URL
      private let comics: [RemoteComic]

      private struct RemoteComic: Decodable {
        let name: String
        let description: String
        let thumbnail: URL
      }

      var character: Character {
        let remoteComics = comics.map { Comic(name: $0.name, description: $0.description, thumbnail: $0.thumbnail) }

        return Character(
          name: name,
          description: description,
          thumbnail: thumbnail,
          comics: remoteComics
        )
      }
    }

    var toModel: Character? {
      return results.first?.character
    }
  }

  public static func map(data: Data) throws -> Character {
    do {
      let root = try JSONDecoder().decode(Root.self, from: data)
      guard let mappedCharacter = root.toModel else {
        throw Error.invalidData
      }

      return mappedCharacter

    } catch {
      throw error
    }
  }
}

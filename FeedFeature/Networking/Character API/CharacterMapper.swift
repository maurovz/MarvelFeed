public final class CharacterMapper {
  public enum Error: Swift.Error {
    case invalidData
  }

  private struct Root: Decodable {
    private let data: Result

    struct Result: Decodable {
      let results: [RemoteCharacter]

      struct RemoteCharacter: Decodable {
        private let name: String
        private let description: String
        private let thumbnail: Thumbnail

        var character: Character {
          return Character(
            name: name,
            description: description,
            thumbnail: "\(thumbnail.path).\(thumbnail.extension)"
          )
        }

        struct Thumbnail: Decodable {
          let path: String
          let `extension`: String
        }
      }
    }

    var toModel: [Character]? {
      return data.results.filter { $0.character.description != "" } .map { $0.character }
    }
  }

  public static func map(data: Data) throws -> [Character] {
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

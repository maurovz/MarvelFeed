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

        var character: Character {
          return Character(
            name: name,
            description: description
          )
        }
      }
    }

    var toModel: [Character]? {
      return data.results.map { $0.character }
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

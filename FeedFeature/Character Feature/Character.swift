import Foundation

public struct Character: Equatable {
  public let name: String
  public let description: String
  public let thumbnail: URL
  public let comics: [Comic]

  public init(name: String, description: String, thumbnail: URL, comics: [Comic]) {
    self.name = name
    self.description = description
    self.thumbnail = thumbnail
    self.comics = comics
  }
}

public struct Comic: Equatable {
  public let name: String
  public let description: String
  public let thumbnail: URL

  public init(name: String, description: String, thumbnail: URL) {
    self.name = name
    self.description = description
    self.thumbnail = thumbnail
  }
}

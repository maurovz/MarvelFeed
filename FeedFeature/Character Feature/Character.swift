import Foundation

public struct Character: Equatable {
  public let name: String
  public let description: String
  public let thumbnail: String

  public init(name: String, description: String, thumbnail: String) {
    self.name = name
    self.description = description
    self.thumbnail = thumbnail
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

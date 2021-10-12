import Foundation

public protocol CharacterLoader {
  typealias Result = Swift.Result<Character, Swift.Error>

  func load(completion: @escaping (Result) -> Void)
}

import Foundation
import FeedFeature

class CharacterViewModel {
  private let character: Character

  lazy var name: String = {
    character.name
  }()

  lazy var description: String = {
    character.name
  }()

  init(character: Character) {
    self.character = character
  }
}

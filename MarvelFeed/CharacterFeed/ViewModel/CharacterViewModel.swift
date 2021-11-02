import Foundation
import FeedFeature
import UIKit

class CharacterViewModel {
  private let character: Character

  lazy var name: String = {
    character.name
  }()

  lazy var description: String = {
    character.description
  }()

  lazy var thumbnail: String = {
    character.thumbnail
  }()

  init(character: Character) {
    self.character = character
  }
}

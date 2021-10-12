import Foundation
import FeedFeature

func makeCharacter(
  name: String,
  description: String,
  thumbnail: URL) -> (model: Character, json: [String: Any]) {

  let json: [String: Any] = [
    "name": name,
    "description": description,
    "thumbnail": thumbnail.absoluteString
  ]

  let comic1 = Comic(name: "Akira", description: "Old school manga", thumbnail: URL(string: "")!)
  let comic2 = Comic(name: "Akira2", description: "Old school manga", thumbnail: URL(string: "")!)

  let model = Character(name: "Boss", description: "Boss of bosses", thumbnail: URL(string: "")!, comics: [comic1, comic2])

  return (model, json)
}

func makeJSON(_ item: [String: Any]) -> Data {
  let root = ["results": [item]]
  return try! JSONSerialization.data(withJSONObject: root)
}

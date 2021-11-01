import Foundation
import FeedFeature

func makeCharacter(
  name: String,
  description: String,
  thumbnail: URL,
  comicName: String,
  comicDescription: String,
  comicThumbnail: URL
  ) -> (model: [Character], json: [String: Any]) {

  let json: [String: Any] = [
    "name": name,
    "description": description
  ]

  let model = Character(name: name, description: description)

  return ([model], json)
}

func makeJSON(_ item: [String: Any]) -> Data {
  let root = ["data": ["results": [item]]]
  return try! JSONSerialization.data(withJSONObject: root)
}

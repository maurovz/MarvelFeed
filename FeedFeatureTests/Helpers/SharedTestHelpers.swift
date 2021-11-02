import Foundation
import FeedFeature

func makeCharacter(
  name: String,
  description: String,
  thumbnail: String
) -> (model: [Character], json: [String: Any]) {

  let json: [String: Any] = [
    "name": name,
    "description": description,
    "thumbnail": [
      "path": "",
      "extension": "https"
    ]
  ]

  let model = Character(name: name, description: description, thumbnail: thumbnail)

  return ([model], json)
}

func makeJSON(_ item: [String: Any]) -> Data {
  let root = ["data": ["results": [item]]]
  return try! JSONSerialization.data(withJSONObject: root)
}

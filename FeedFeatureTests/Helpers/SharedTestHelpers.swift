import Foundation
import FeedFeature

func makeCharacter(
  name: String,
  description: String,
  thumbnail: URL,
  comicName: String,
  comicDescription: String,
  comicThumbnail: URL
  ) -> (model: Character, json: [String: Any]) {

  let json: [String: Any] = [
    "name": name,
    "description": description,
    "thumbnail": thumbnail.absoluteString,
    "comics": [
      ["name": comicName,
      "description": comicDescription,
      "thumbnail": comicThumbnail.absoluteString]
    ]
  ]

  let comic1 = Comic(name: comicName, description: comicDescription, thumbnail: comicThumbnail)
  let model = Character(name: name, description: description, thumbnail: thumbnail, comics: [comic1])

  return (model, json)
}

func makeJSON(_ item: [String: Any]) -> Data {
  let root = ["results": [item]]
  return try! JSONSerialization.data(withJSONObject: root)
}

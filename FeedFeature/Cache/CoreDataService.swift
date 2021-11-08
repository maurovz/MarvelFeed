import CoreData

public struct CoreDataServices {
  public init() { }

  public func saveCharactersToCache(characters: [Character]) {
    let context = CoreDataStack.persistentContainer.viewContext

    for character in characters {
      let entity = CharacterDescription(context: context)
      entity.characterName = character.name
      entity.characterDescription = character.description
      entity.characterThumbnail = character.thumbnail
      CoreDataStack.saveContext()
    }
  }

  public func loadCharactersFromCoreData() -> [Character] {
    let entities = fetchCharacterEntity()
    var characters: [Character] = []

    for entity in entities {
      guard
        let name = entity.characterName,
        let description = entity.characterDescription,
        let thumbnail = entity.characterThumbnail
      else {
        continue
      }

      characters.append(Character(name: name, description: description, thumbnail: thumbnail))
    }

    return characters
  }

  public func deleteEntityFromCoreData(entity: String) -> Bool {
    let context = CoreDataStack.persistentContainer.viewContext
    do {
      let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
      let request = NSBatchDeleteRequest(fetchRequest: fetch)
      try context.execute(request)
      return true
    } catch {
      return false
    }
  }

  private func fetchCharacterEntity() -> [CharacterDescription] {
    let context = CoreDataStack.persistentContainer.viewContext
    do {
      return try context.fetch(CharacterDescription.fetchRequest())
    } catch {
      return []
    }
  }
}

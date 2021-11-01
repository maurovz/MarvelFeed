import UIKit
import FeedFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  private lazy var navigationController = UINavigationController(
    rootViewController: CharacterFeedViewController(
      characterFeedViewModel: CharacterFeedViewModel(loader: getLoader())
    )
  )

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }

    window = UIWindow(windowScene: scene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }

  func getLoader() -> RemoteCharacterLoader {
    let client = URLSessionHTTPClient(session: .shared)

    let timestamp = "ts2020"
    let publicKey = "0c5a611113f2aa779e8988bb6a0e8447"
    let baseURL = "https://gateway.marvel.com:443/v1/public/characters?orderBy=-modified"
    let url = URL(string: "\(baseURL)&ts=\(timestamp)&apikey=\(publicKey)&hash=cb0c0b92b46b5a48de738ca8d92470e6")!

    return RemoteCharacterLoader(url: url, client: client)
  }
}

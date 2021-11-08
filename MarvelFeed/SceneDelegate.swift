import UIKit
import FeedFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  private lazy var navigationController = UINavigationController(
    rootViewController: CharacterFeedViewController(
      characterFeedViewModel: CharacterFeedViewModel(loader: getLoader(), didSelectAction: goToDetailView)
    )
  )

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }

    window = UIWindow(windowScene: scene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }

  func goToDetailView(for viewModel: CharacterViewModel) {
    let viewController = CharacterDetailViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }

  func getLoader() -> RemoteCharacterLoader {
    let client = URLSessionHTTPClient(session: .shared)
    return RemoteCharacterLoader(url: Constants.url, client: client, cache: CoreDataServices())
  }
}

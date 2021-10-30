import UIKit

class CharacterFeedViewController: UIViewController {
  private let characterFeedViewModel: CharacterFeedViewModel
  private var characterView = UIView()

  public init(characterFeedViewModel: CharacterFeedViewModel) {
    self.characterFeedViewModel = characterFeedViewModel
    super.init(nibName: nil, bundle: Bundle(for: CharacterFeedViewController.self))
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    characterFeedViewModel.fetch()
  }

  public override func loadView() {
    view = characterView
  }
}

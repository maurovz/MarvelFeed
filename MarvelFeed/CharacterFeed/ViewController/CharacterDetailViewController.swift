import UIKit

final class CharacterDetailViewController: UIViewController {
  private let viewModel: CharacterViewModel
  private let characterView = CharacterDetailView()

  public init(viewModel: CharacterViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: Bundle(for: CharacterDetailViewController.self))
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func loadView() {
    view = characterView
  }
}

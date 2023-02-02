import UIKit

final class AppNavigator: IAppNavigator {
    
    func toCharacterDetailView(_ character: Character) {
        let characterView = CharacterView.Factory().create(character: character)
        push(viewController: characterView)
    }
    
    // MARK: - Private methods
    private func push(viewController: UIViewController) {
        let topViewController = UIApplication.getVisibleViewController()
        topViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

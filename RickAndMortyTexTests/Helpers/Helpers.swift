import UIKit
@testable import RickAndMortyTex

func tap(_ button: UIButton) {
    button.sendActions(for: .touchUpInside)
    (button.gestureRecognizers?.first as? BindableGestureRecognizer)?.execute()
}

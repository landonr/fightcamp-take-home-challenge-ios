import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = .init(windowScene: windowScene)
        window?.rootViewController = HelloViewController() // instantiate the view controller here
        window?.makeKeyAndVisible()
    }
}

class HelloViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor = .red
    }
}

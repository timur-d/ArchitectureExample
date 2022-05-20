import Foundation
import UIKit


class AppController {
    static let shared = AppController()

    var appCoordinator: AppCoordinator?

    private var window: UIWindow?

    func configureApp(window: UIWindow) {
        self.window = window
        self.appCoordinator = AppCoordinator(window: window)
        setupUI()
    }

    func setupUI() {
        self.appCoordinator?.start()
    }
}


extension AppController: AppControllerProtocol {
    var appCoordinatorService: AppCoordinatorServiceProtocol? {
        appCoordinator
    }
}

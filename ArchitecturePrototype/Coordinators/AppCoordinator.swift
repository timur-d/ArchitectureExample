//
// Created by Mikhail Mulyar on 11/12/2019.
//

import Foundation
import UIKit


final class AppCoordinatorContext {}


protocol AppCoordinatorFactory: AutoFactoryImplementation,
                                TabCoordinatorProvider {
}


final class AppCoordinator: BaseCoordinator, Coordinator, AppCoordinatorServiceProtocol {
    weak var window: UIWindow?
    var context: AppCoordinatorContext?

    private let factory: AppCoordinatorFactory

    init(factory: AppCoordinatorFactory = AppCoordinatorFactoryImplementation(), window: UIWindow?) {
        self.window = window
        self.factory = factory
        super.init()
    }

    private var tabCoordinator: TabCoordinator? {
        return self.childCoordinators.first {
            $0 is TabCoordinator
        } as? TabCoordinator
    }

    func start() {
        showMainScreen()
    }

    private func showMainScreen() {
        let tabBarController = AppTabBarController()
        let coordinator = factory.getTabCoordinator(tabController: tabBarController, parent: self) { _ in
        }
        self.window?.rootViewController = tabBarController

        self.add(coordinator: coordinator)
        coordinator.start()
    }

    override func route(to path: AppPath) {
        self.tabCoordinator?.route(to: path)
    }
}

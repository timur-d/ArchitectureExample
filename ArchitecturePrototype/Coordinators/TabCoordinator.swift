//
// Created by Mikhail Mulyar on 20/12/2019.
//

import Foundation
import UIKit


final class TabContext {}


protocol TabCoordinatorFactory: AutoFactoryImplementation, FirstCoordinatorProvider, SecondCoordinatorProvider, ThirdCoordinatorProvider {}


final class TabCoordinator: BaseCoordinator, Coordinator, AutoInjectableCoordinator {
    weak var tabController: AppTabBarController?
    var context: TabContext

    private let factory: TabCoordinatorFactory

    init(factory: TabCoordinatorFactory = TabCoordinatorFactoryImplementation(),
         tabController: AppTabBarController,
         selectedIndex: Int = 0,
         parent: BaseCoordinator,
         exitTo: @escaping (BaseCoordinator) -> Void) {
        self.tabController = tabController
        self.context = TabContext()
        self.factory = factory

        super.init(parent: parent, exitTo: exitTo)

        self.observeLifetime(of: tabController)
    }

    func start() {
        let firstController = AppNavigationController()
        let secondController = AppNavigationController()
        let thirdController = AppNavigationController()

        let firstItem = UITabBarItem(title: "First", image: nil, selectedImage: nil)
        firstController.tabBarItem = firstItem

        let firstCoordinator = factory.getFirstCoordinator(navigationController: firstController, parent: self) { _ in }

        let secondItem = UITabBarItem(title: "Second", image: nil, selectedImage: nil)
        secondController.tabBarItem = secondItem

        let secondCoordinator = factory.getSecondCoordinator(navigationController: secondController, parent: self) { _ in }

        let thirdItem = UITabBarItem(title: "Third", image: nil, selectedImage: nil)
        thirdController.tabBarItem = thirdItem

        let thirdCoordinator = factory.getThirdCoordinator(navigationController: thirdController, parent: self) { _ in }

        tabController?.viewControllers = [firstController, secondController, thirdController]

        self.add(coordinator: firstCoordinator)
        firstCoordinator.start()

        self.add(coordinator: secondCoordinator)
        secondCoordinator.start()

        self.add(coordinator: thirdCoordinator)
        thirdCoordinator.start()
    }

    override func route(to path: AppPath) {}
}

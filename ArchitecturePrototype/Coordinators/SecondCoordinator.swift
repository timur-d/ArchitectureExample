//
// Created by Mikhail Mulyar on 20/12/2019.
//

import Foundation
import UIKit


final class SecondContext: AnySecondModuleContext {}


protocol SecondCoordinatorFactory: AutoFactoryImplementation, SecondModuleModuleProvider {}


final class SecondCoordinator: BaseCoordinator, Coordinator, AutoInjectableCoordinator {

    weak var navigationController: AppNavigationController?
    var context: SecondContext

    private let factory: SecondCoordinatorFactory

    init(factory: SecondCoordinatorFactory = SecondCoordinatorFactoryImplementation(),
         navigationController: AppNavigationController,
         parent: BaseCoordinator,
         exitTo: @escaping (BaseCoordinator) -> Void) {

        self.factory = factory
        self.navigationController = navigationController
        self.context = SecondContext()

        super.init(parent: parent, exitTo: exitTo)
    }

    func start() {
        let controller = factory.getSecondModuleModule(context: context, router: self).view
        self.navigationController?.pushViewController(controller, animated: true)
        self.observeLifetime(of: controller)
    }
}


extension SecondCoordinator: SecondModuleRouterInput {}
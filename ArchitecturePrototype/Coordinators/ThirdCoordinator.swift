//
// Created by Mikhail Mulyar on 20/12/2019.
//

import Foundation
import UIKit


final class ThirdContext: AnyThirdModuleContext {}


protocol ThirdCoordinatorFactory: AutoFactoryImplementation, ThirdModuleModuleProvider, FirstCoordinatorProvider {}


final class ThirdCoordinator: BaseCoordinator, Coordinator, AutoInjectableCoordinator {

    weak var navigationController: AppNavigationController?
    var context: ThirdContext

    private let factory: ThirdCoordinatorFactory

    init(factory: ThirdCoordinatorFactory = ThirdCoordinatorFactoryImplementation(),
         navigationController: AppNavigationController,
         parent: BaseCoordinator,
         exitTo: @escaping (BaseCoordinator) -> Void) {

        self.factory = factory
        self.navigationController = navigationController
        self.context = ThirdContext()

        super.init(parent: parent, exitTo: exitTo)
    }

    func start() {
        let controller = factory.getThirdModuleModule(context: context, router: self).view
        self.navigationController?.pushViewController(controller, animated: true)
        self.observeLifetime(of: controller)
    }
}


extension ThirdCoordinator: ThirdModuleRouterInput {
    func showTestModel(withId id: Int) {
        fatalError("Not implemented")
    }
}

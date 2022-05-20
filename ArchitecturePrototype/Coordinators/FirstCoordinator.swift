//
// Created by Mikhail Mulyar on 20/12/2019.
//

import Foundation
import UIKit


final class FirstContext: AnyFirstModuleContext {}


protocol FirstCoordinatorFactory: AutoFactoryImplementation, FirstModuleModuleProvider {}


final class FirstCoordinator: BaseCoordinator, Coordinator, AutoInjectableCoordinator {

    weak var navigationController: AppNavigationController?
    var context: FirstContext

    private let factory: FirstCoordinatorFactory

    init(factory: FirstCoordinatorFactory = FirstCoordinatorFactoryImplementation(),
         navigationController: AppNavigationController,
         parent: BaseCoordinator,
         exitTo: @escaping (BaseCoordinator) -> Void) {

        self.factory = factory
        self.navigationController = navigationController
        self.context = FirstContext()

        super.init(parent: parent, exitTo: exitTo)
    }

    func start() {
        let controller = factory.getFirstModuleModule(context: context, router: self).view
        self.navigationController?.pushViewController(controller, animated: true)
        self.observeLifetime(of: controller)
    }
}


extension FirstCoordinator: FirstModuleRouterInput {
    func didTapInfo() {
    }
}
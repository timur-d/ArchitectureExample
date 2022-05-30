//
//  DetailedTestModelCoordinator.swift
//  ArchitecturePrototype
//
//  Created by lrocky on 30.05.2022.
//

import Foundation

final class DetailedTestModelContext: AnyDetailedTestModelContext {}


protocol DetailedTestModelCoordinatorFactory: AutoFactoryImplementation, DetailedTestModelModuleProvider {}


final class DetailedTestModelCoordinator: BaseCoordinator, Coordinator, AutoInjectableCoordinator {

    weak var navigationController: AppNavigationController?
    var context: DetailedTestModelContext

    private let factory: DetailedTestModelCoordinatorFactory

    private let id: Int

    init(id: Int,
         factory: DetailedTestModelCoordinatorFactory = DetailedTestModelCoordinatorFactoryImplementation(),
         navigationController: AppNavigationController,
         parent: BaseCoordinator,
         exitTo: @escaping (BaseCoordinator) -> Void) {
        self.id = id

        self.factory = factory
        self.navigationController = navigationController
        self.context = DetailedTestModelContext()

        super.init(parent: parent, exitTo: exitTo)
    }

    func start() {
        let controller = factory.getDetailedTestModelModule(id: self.id,
                                                            context: self.context,
                                                            router: self).view
        self.navigationController?.present(controller, animated: true)
        self.observeLifetime(of: controller)
    }
}

extension DetailedTestModelCoordinator: DetailedTestModelRouterInput {}

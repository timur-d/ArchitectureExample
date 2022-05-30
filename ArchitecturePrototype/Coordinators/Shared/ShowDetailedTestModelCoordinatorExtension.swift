//
//  ShowDetailedTestModelCoordinatorExtension.swift
//  ArchitecturePrototype
//
//  Created by lrocky on 30.05.2022.
//

import Foundation
import UIKit

#warning("This is only example, don't use shared logic like this")
#warning("Shared logic should be used for common viper pickers or alerts")
#warning("When different flows should process error's in common style or present some popup during flow")
protocol ShowDetailedTestModelCoordinatorExtension: BaseCoordinator {
    var detailedTestModelCoordinatorProvider: DetailedTestModelCoordinatorProvider { get }
    var navigationController: AppNavigationController? { get }

    func showTestModel(withId id: Int)

    // Normal usage method
    // func processError(_ error: AppError)
}

extension ShowDetailedTestModelCoordinatorExtension {
    func showTestModel(withId id: Int) {
        guard let navigationController = self.navigationController else { return }
        let coordinator = self.detailedTestModelCoordinatorProvider
            .getDetailedTestModelCoordinator(id: id,
                                             navigationController: navigationController,
                                             parent: self,
                                             exitTo: { _ in })
        self.add(coordinator: coordinator)
        coordinator.start()
    }
}

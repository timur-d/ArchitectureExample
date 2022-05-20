//
// Created by Mikhail Mulyar on 18.05.2022.
//

import UIKit


public protocol CoordinatorLifecycleMethods {
    var exitTo: (BaseCoordinator) -> Void { get set }

    func start()
    func route(to path: AppPath)
    func start(controllers: [UIViewController], with path: AppPath)
}


extension Coordinator {
    func start(controllers: [UIViewController], with path: AppPath) {
        self.start()
    }
}


public protocol Coordinator: CoordinatorLifecycleMethods {
    associatedtype Context

    var context: Context { get set }
}


public typealias CoordinatorType = BaseCoordinator & CoordinatorLifecycleMethods


public class BaseCoordinator: NSObject {
    weak var parent: BaseCoordinator?
    var childCoordinators: [BaseCoordinator] = []

    var exitTo: (BaseCoordinator) -> Void

    init(parent: BaseCoordinator? = nil,
         exitTo: @escaping (BaseCoordinator) -> Void = { _ in
         }) {
        self.parent = parent
        self.exitTo = exitTo

        super.init()
    }

    func add(coordinator: BaseCoordinator) {
        if !self.childCoordinators.contains(where: { $0 === coordinator }) {
            self.childCoordinators.append(coordinator)
        }
    }

    func remove(coordinator: BaseCoordinator) {
        guard let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) else {
            return
        }
        self.childCoordinators.remove(at: index)
    }

    func removeFromParent() {
        self.parent?.remove(coordinator: self)
        self.didRemoved()
        self.parent = nil
    }

    func didRemoved() {
        self.childCoordinators.forEach {
            $0.didRemoved()
        }
        self.cleanPreviousControllerLifetimeObservation()
        self.exitTo(self)
        // release refs
        self.childCoordinators = []
    }

    func observeLifetime(of controller: UIViewController) {
        #warning("Implement lifetime observation")
        //        { [weak self] in
        //            guard let `self` = self else { return }
        //            self.removeFromParent()
        //        }
    }

    func cleanPreviousControllerLifetimeObservation() {
        #warning("Implement lifetime ending")
    }

    func route(to path: AppPath) {
        parent?.route(to: path)
    }

    func isPathOpen(_ path: AppPath) -> Bool {
        parent?.isPathOpen(path) ?? false
    }

    func show(navigationController: AppNavigationController?, with controllers: [UIViewController]) {
        guard let navigationController = navigationController else {
            return
        }
        var presentControllers = navigationController.viewControllers
        presentControllers.append(contentsOf: controllers)

        navigationController.setViewControllers(presentControllers, animated: true)
    }
}

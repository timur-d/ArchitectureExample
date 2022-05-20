//
// Created by Mikhail Mulyar on 20/12/2019.
//

import Foundation


protocol AppControllerProtocol {
    var appCoordinatorService: AppCoordinatorServiceProtocol? { get }
}


protocol AppCoordinatorServiceProtocol {
    func route(to path: AppPath)
}

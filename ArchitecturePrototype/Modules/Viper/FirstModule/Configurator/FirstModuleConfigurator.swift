//
//  FirstModuleConfigurator.swift
//

import Foundation


public final class FirstModuleConfigurator: AutoInjectableModule {
    // MARK: - FirstModuleModuleOutput
    public static func configure(databaseService: DatabaseServiceProtocol,
                                 networkService: NetworkServiceProtocol,
                                 context: AnyFirstModuleContext,
                                 router: FirstModuleRouterInput) -> (FirstModuleViewType, FirstModuleModuleInput) {
        let interactor = FirstModuleInteractor(networkService: networkService,
                                               databaseService: databaseService)
        let presenter = FirstModulePresenter(interactor: interactor, router: router)
        let view = FirstModuleViewController(output: presenter)

        interactor.output = presenter
        presenter.context = context
        presenter.viewInput = view
        return (view, presenter)
    }
}

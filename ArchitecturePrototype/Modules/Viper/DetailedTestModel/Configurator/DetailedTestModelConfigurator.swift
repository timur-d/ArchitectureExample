//
//  DetailedTestModelConfigurator.swift
//

import Foundation


public final class DetailedTestModelConfigurator: AutoInjectableModule {
    // MARK: - DetailedTestModelModuleOutput
    public static func configure(id: Int,
                                 databaseService: DatabaseServiceProtocol,
                                 networkService: NetworkServiceProtocol,
                                 context: AnyDetailedTestModelContext,
                                 router: DetailedTestModelRouterInput) -> (DetailedTestModelViewType, DetailedTestModelModuleInput) {
        let interactor = DetailedTestModelInteractor(databaseService: databaseService,
                                                     networkService: networkService)
        let presenter = DetailedTestModelPresenter(id: id,
                                                   interactor: interactor,
                                                   router: router)
        let view = DetailedTestModelViewController(output: presenter)

        interactor.output = presenter
        presenter.context = context
        presenter.viewInput = view
        return (view, presenter)
    }
}

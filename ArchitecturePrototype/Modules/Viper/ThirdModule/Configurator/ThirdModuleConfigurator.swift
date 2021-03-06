//
//  ThirdModuleConfigurator.swift
//

import Foundation


public final class ThirdModuleConfigurator: AutoInjectableModule {
    // MARK: - ThirdModuleModuleOutput
    public static func configure(databaseService: DatabaseServiceProtocol,
                                 context: AnyThirdModuleContext,
                                 router: ThirdModuleRouterInput) -> (ThirdModuleViewType, ThirdModuleModuleInput) {
        let interactor = ThirdModuleInteractor()
        let presenter = ThirdModulePresenter(interactor: interactor, router: router)
        let view = ThirdModuleViewController(output: presenter)

        interactor.output = presenter
        presenter.context = context
        presenter.viewInput = view
        return (view, presenter)
    }
}
//
//  SecondModuleConfigurator.swift
//

import Foundation


public final class SecondModuleConfigurator: AutoInjectableModule {
    // MARK: - SecondModuleModuleOutput
    public static func configure(databaseService: DatabaseServiceProtocol,
                                 context: AnySecondModuleContext,
                                 router: SecondModuleRouterInput) -> (SecondModuleViewType, SecondModuleModuleInput) {
        let interactor = SecondModuleInteractor()
        let presenter = SecondModulePresenter(interactor: interactor, router: router)
        let view = SecondModuleViewController(output: presenter)

        interactor.output = presenter
        presenter.context = context
        presenter.viewInput = view
        return (view, presenter)
    }
}
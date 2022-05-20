//
//  FirstModuleConfigurator.swift
//

import Foundation


public final class FirstModuleConfigurator: AutoInjectableModule {
    // MARK: - FirstModuleModuleOutput
    public static func configure(input: Any? = nil,
                                 context: AnyFirstModuleContext,
                                 router: FirstModuleRouterInput) -> (FirstModuleViewType, FirstModuleModuleInput) {
        let interactor = FirstModuleInteractor()
        let presenter = FirstModulePresenter(interactor: interactor, router: router)
        let view = FirstModuleViewController(output: presenter)

        interactor.output = presenter
        presenter.context = context
        presenter.viewInput = view
        return (view, presenter)
    }
}
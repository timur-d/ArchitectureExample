//
//  FirstModulePresenter.swift
//


final class FirstModulePresenter {

    private(set) var interactor: FirstModuleInteractorInput
    private(set) weak var router: FirstModuleRouterInput!
    weak var context: AnyFirstModuleContext!
    weak var viewInput: FirstModuleViewInput!

    private(set) var model: FirstModuleViewModel

    init(interactor: FirstModuleInteractorInput, router: FirstModuleRouterInput) {
        self.interactor = interactor
        self.router = router
        let modelValue = FirstModuleViewModel.initial
        self.model = modelValue
    }
}


extension FirstModulePresenter: FirstModuleModuleInput {}


extension FirstModulePresenter: FirstModuleViewOutput {
    func viewIsReady() {}

    func update(with updates: [FirstModuleViewModel.Updates], notify: Bool = false) {
        self.model = self.model.updated(updates)

        if notify {
            self.viewInput.update(with: updates)
        }
    }
}


extension FirstModulePresenter: FirstModuleInteractorOutput {}

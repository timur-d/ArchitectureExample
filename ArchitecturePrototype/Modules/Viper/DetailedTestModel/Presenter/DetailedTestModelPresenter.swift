//
//  DetailedTestModelPresenter.swift
//

import ReactiveSwift


final class DetailedTestModelPresenter {
    private let (lifetime, token) = Lifetime.make()

    private(set) var interactor: DetailedTestModelInteractorInput
    private(set) weak var router: DetailedTestModelRouterInput!
    weak var context: AnyDetailedTestModelContext!
    weak var viewInput: DetailedTestModelViewInput!

    private(set) var model: DetailedTestModelViewModel

    private let id: Int

    init(id: Int,
         interactor: DetailedTestModelInteractorInput,
         router: DetailedTestModelRouterInput) {
        self.id = id
        
        self.interactor = interactor
        self.router = router

        let modelValue = DetailedTestModelViewModel.initial
        self.model = modelValue
    }
}


extension DetailedTestModelPresenter: DetailedTestModelModuleInput {

}


extension DetailedTestModelPresenter: DetailedTestModelViewOutput {
    func viewIsReady() {
        lifetime += self.interactor.getTestModel(byId: self.id)
            .observe(on: UIScheduler())
            .startWithValues { [weak self] model in
                self?.update(with: [.id("\(model?.id ?? -1)"),
                                    .strings(model?.string ?? "")],
                             notify: true)
            }
    }
    func update(with updates: [DetailedTestModelViewModel.Updates], notify: Bool = false) {
        self.model = self.model.updated(updates)

        if notify {
            self.viewInput.update(with: updates)
        }
    }
}


extension DetailedTestModelPresenter: DetailedTestModelInteractorOutput {}

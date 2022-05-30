//
//  FirstModulePresenter.swift
//

import ReactiveSwift


final class FirstModulePresenter {

    private let (lifetime, token) = Lifetime.make()

    private(set) var interactor: FirstModuleInteractorInput
    private(set) weak var router: FirstModuleRouterInput!
    weak var context: AnyFirstModuleContext!
    weak var viewInput: FirstModuleViewInput!

    // Action's
    private(set) lazy var searchAction: Action<Void, Void, Never> = .init(enabledIf: self.formattedSearchQueryProperty.map { $0 != nil }.and(self.loadingInProgress.negate()),
                                                                            execute: {
        [unowned self] in

        self.formattedSearchQueryProperty.value.flatMap { self.performSearchById(id: $0) }

        // keep search up to 1 in 1 second
        return SignalProducer.empty.delay(1.0, on: QueueScheduler.main)
    })

    private lazy var loadingInProgress = MutableProperty(false)
    private(set) lazy var searchQueryProperty = MutableProperty<String?>(nil)
    private lazy var formattedSearchQueryProperty: Property<Int?> = searchQueryProperty.map { stringValue in
        return stringValue.flatMap { Int($0) }
    }

    // ViewModel
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

    func performSearchById(id: Int) {
        self.viewInput?.dismissKeyboard()
        self.loadingInProgress.value = true

        let fetchProducer = self.interactor.fetchCollectionsModel(byId: id)
            .on(value: { [weak self] value in
                self?.update(with: [.searchInProgress(value == nil)],
                             notify: true)
            })
        let updateProducer = self.interactor.updateCollectionsModel(byId: id)
            .on(terminated: { [weak self] in
                self?.update(with: [.searchInProgress(false)],
                             notify: true)
            })

        let concatProducer = fetchProducer.concat(updateProducer)


        lifetime += concatProducer
            .observe(on: UIScheduler())
            .on(terminated: { [weak self] in
                self?.loadingInProgress.value = false
            })
            .startWithValues { [weak self] value in
                guard let self = self else { return }

                var updates = [FirstModuleViewModel.Updates]()
                updates.append(.idString("Id: \(id)"))

                defer {
                    self.update(with: updates,
                                notify: true)
                }

                guard let value = value else {
                    updates.append(contentsOf: [.idsString(nil),
                                                .stringsString("Not found"),
                                                .datesString(nil)])
                    return
                }

                updates.append(contentsOf: [.idsString("Ints: \(value.intValues.lazy.map { "\($0 ?? 0) "}.joined(separator: ", "))"),
                                            .stringsString("Strings: \(value.strings.joined(separator: ", "))"),
                                            .datesString("Dates: \(value.dates?.lazy.map { $0.description }.joined(separator: ", ") ?? "none")")])
            }

    }

    func viewIsReady() {}

    func update(with updates: [FirstModuleViewModel.Updates], notify: Bool = false) {
        self.model = self.model.updated(updates)

        if notify {
            self.viewInput.update(with: updates)
        }
    }
}


extension FirstModulePresenter: FirstModuleInteractorOutput {}

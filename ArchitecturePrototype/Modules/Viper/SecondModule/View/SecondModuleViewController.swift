//
//  SecondModuleViewController.swift
//

import UIKit
import SectionDataSource


public protocol SecondModuleViewType: BaseViewController {}

// all secondary ViewController's must conform to `injectionExportType`.
// sourcery: injectionExportType=SecondModuleViewType
final class SecondModuleViewController: BaseViewController, 
                                        SecondModuleViewType {

    // MARK: - Initializers
    required init(output: SecondModuleViewOutput) {
        self.output = output
        super.init()

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Variables
    let output: SecondModuleViewOutput

    private let tableView = UITableView()

    // MARK: - Initialize
    func setup() {

    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
}


// MARK: - SecondModuleViewInput
extension SecondModuleViewController: SecondModuleViewInput {
    func update(with updates: [SecondModuleViewModel.Updates]) {

    }

    func contentDidUpdate(updates: DataSourceUpdates) {
        switch updates {
        case .reload:
            break
        case .initial(let changes):
            tableView.reloadData()
            changes.forceUpdate()
        case .update(let changes):
            tableView.reload(using: changes, with: .fade)
        }
    }

    func searchContentDidUpdate(updates: DataSourceUpdates) {
        switch updates {
        case .reload:
            break
        case .initial:
            break
        case .update:
            break
        }
    }

    func didUpdateSearchState(isSearching: Bool) {}

}
//
//  ThirdModuleViewController.swift
//

import UIKit
import SectionDataSource


public protocol ThirdModuleViewType: BaseViewController {}

// all secondary ViewController's must conform to `injectionExportType`.
// sourcery: injectionExportType=ThirdModuleViewType
final class ThirdModuleViewController: BaseViewController, 
                                       ThirdModuleViewType {

    // MARK: - Initializers
    required init(output: ThirdModuleViewOutput) {
        self.output = output
        super.init()

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Variables
    let output: ThirdModuleViewOutput

    let tableView = UITableView()

    // MARK: - Initialize
    func setup() {

    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
}


// MARK: - ThirdModuleViewInput
extension ThirdModuleViewController: ThirdModuleViewInput {
    func update(with updates: [ThirdModuleViewModel.Updates]) {
        for update in updates {
            switch update {
            case .value:
                break
            }
        }
    }

    func contentDidUpdate(updates: DataSourceUpdates) {
        switch updates {
        case .reload:
            self.tableView.reloadData()
        case .initial(let changes):
            self.tableView.reloadData()
            changes.forceUpdate()
        case .update(let changes):
            self.tableView.reload(using: changes, with: .fade)
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
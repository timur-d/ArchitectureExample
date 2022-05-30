//
//  ThirdModuleViewController.swift
//

import SectionDataSource
import ReactiveCocoa
import UIKit


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
    private let clearBarButton = UIBarButtonItem(title: "Clear all", style: .plain,
                                                 target: nil, action: nil)
    private let fillDatabaseButton = UIBarButtonItem(title: "Fill db", style: .plain,
                                                     target: nil, action: nil)

    let output: ThirdModuleViewOutput

    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    // MARK: - Initialize
    func setup() {
        self.navigationItem.leftBarButtonItem = self.clearBarButton
        self.navigationItem.rightBarButtonItem = self.fillDatabaseButton
    }

    func setupAfterDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        self.fillDatabaseButton.reactive.pressed = CocoaAction(self.output.fillDatabaseAction)
        self.clearBarButton.reactive.pressed = CocoaAction(self.output.clearDatabaseAction)
    }

    func addViews() {
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAfterDidLoad()
        self.addViews()
        output.viewIsReady()
    }
}

// MARK: - UITableViewDelegate
extension ThirdModuleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        #warning("use view model")
        let item = self.output.itemAtIndexPath(indexPath)
        self.output.onItemSelectedAction.apply(item.id).start()
    }
}

// MARK: - UITableViewDataSource
extension ThirdModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.output.itemAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        cell.textLabel?.text = ["\(model.id)", model.string].joined(separator: " ")
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        output.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfItemsInSection(section)
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

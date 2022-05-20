//
//  FirstModuleViewController.swift
//

import UIKit


public protocol FirstModuleViewType: BaseViewController {
}


// all secondary ViewController's must conform to `injectionExportType`.
// sourcery: injectionExportType=FirstModuleViewType
final class FirstModuleViewController: BaseViewController,
                                       FirstModuleViewType {

    // MARK: - Initializers
    required init(output: FirstModuleViewOutput) {
        self.output = output
        super.init()

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Variables
    let output: FirstModuleViewOutput


    // MARK: - Initialize
    func setup() {
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
}


// MARK: - FirstModuleViewInput
extension FirstModuleViewController: FirstModuleViewInput {
    func update(with updates: [FirstModuleViewModel.Updates]) {
        for update in updates {
            switch update {
            case .value:
                break
            }
        }
    }
}
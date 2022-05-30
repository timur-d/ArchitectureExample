//
//  FirstModuleViewController.swift
//

import ReactiveCocoa
import ReactiveSwift
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

    // Views
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var searchCancelButton = UIBarButtonItem(barButtonSystemItem: .done,
                                                          target: self,
                                                          action: #selector(onSearchCancel(sender:)))
    private lazy var searchActionButton = UIBarButtonItem(barButtonSystemItem: .search,
                                                          target: nil,
                                                          action: nil)

    private lazy var searchIdTextFieldBar = UIToolbar()
    private lazy var searchIdTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad

        self.searchIdTextFieldBar.autoresizingMask = .flexibleHeight
        self.searchIdTextFieldBar.items = [self.searchCancelButton,
                                           .init(barButtonSystemItem: .flexibleSpace,
                                                 target: nil, action: nil),
                                           self.searchActionButton]
        textField.inputAccessoryView = searchIdTextFieldBar

        return textField
    }()

    private let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()

    private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let stringsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let intsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let datesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    

    // MARK: - Initialize
    func setup() {
        self.searchIdTextField.placeholder = "Enter id to search"
        self.searchIdTextField.setContentHuggingPriority(.required, for: .vertical)
        self.searchIdTextField.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAfterDidLoad()
        output.viewIsReady()
    }

    // MARK: - Handler's
    @objc
    func onSearchCancel(sender: Any? = nil) {
        self.searchIdTextField.resignFirstResponder()
    }
}

// MARK: - Setup's
private extension FirstModuleViewController {
    func setupAfterDidLoad() {
        addSubviews()
        bindHandlers()
    }

    func addSubviews() {
        // add stack
        self.view.addSubview(self.stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false

        [self.searchIdTextField,
         self.separator,
         self.idLabel,
         self.intsLabel,
         self.stringsLabel,
         self.datesLabel,
         spacerView]
            .forEach {
                self.stackView.addArrangedSubview($0)
            }

        NSLayoutConstraint.activate([
            self.separator.heightAnchor.constraint(equalToConstant: 1)
        ])

        self.activityIndicator.hidesWhenStopped = true

        self.view.addSubview(self.activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: separator.bottomAnchor),

            activityIndicator.leftAnchor.constraint(equalTo: view.leftAnchor),
            activityIndicator.rightAnchor.constraint(equalTo: view.rightAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func bindHandlers() {
        self.searchActionButton.reactive.pressed = CocoaAction(self.output.searchAction)

        self.output.searchQueryProperty <~ self.searchIdTextField.reactive.continuousTextValues
    }
}

// MARK: - FirstModuleViewInput
extension FirstModuleViewController: FirstModuleViewInput {
    func update(with updates: [FirstModuleViewModel.Updates]) {
        for update in updates {
            switch update {
            case .searchInProgress(let value):
                if value {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            case .datesString(let value):
                self.datesLabel.text = value
            case .idString(let value):
                self.idLabel.text = value
            case .idsString(let value):
                self.intsLabel.text = value
            case .stringsString(let value):
                self.stringsLabel.text = value
            }
        }
    }

    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

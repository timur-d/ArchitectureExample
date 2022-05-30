//
//  DetailedTestModelViewController.swift
//

import UIKit


public protocol DetailedTestModelViewType: BaseViewController {}

// all secondary ViewController's must conform to `injectionExportType`.
// sourcery: injectionExportType=DetailedTestModelViewType
final class DetailedTestModelViewController: BaseViewController, 
                                             DetailedTestModelViewType {

    // MARK: - Initializers
    required init(output: DetailedTestModelViewOutput) {
        self.output = output
        super.init()

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Variables
    let output: DetailedTestModelViewOutput

    // MARK: - Views
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    let idKeyLabel: UILabel = {
        let idTitleLabel = UILabel()
        idTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        idTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return idTitleLabel
    }()
    let idValueLabel: UILabel = {
        let idTitleLabel = UILabel()
        idTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return idTitleLabel
    }()

    let stringsKeyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    let stringsValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    // MARK: - Initialize
    func setup() {
        idKeyLabel.text = "Id:"
        stringsKeyLabel.text = "Strings:"
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false

        [idKeyLabel,
         idValueLabel,
         stringsKeyLabel,
         stringsValueLabel,
         spacerView].forEach {
            stackView.addArrangedSubview($0)
        }

        output.viewIsReady()
    }
}


// MARK: - DetailedTestModelViewInput
extension DetailedTestModelViewController: DetailedTestModelViewInput {
    func update(with updates: [DetailedTestModelViewModel.Updates]) {
        for update in updates {
            switch update {
            case .id(let value):
                self.idValueLabel.text = value
            case .strings(let value):
                self.stringsValueLabel.text = value
            }
        }
    }
}

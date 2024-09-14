//
//  AddItemViewController.swift
//  Map
//
//  Created by Paulo Magro on 02/09/24.
//

import UIKit


class AddItemViewController: UIViewController {
    let viewModel: AddItemViewModel
    
    lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 16, left: 16, bottom: 0, right: 16)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var typeSegmented: UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.insertSegment(withTitle: "Achei um item", at: 0, animated: false)
        segmented.insertSegment(withTitle: "Perdi um item", at: 1, animated: false)
        segmented.selectedSegmentIndex = 0
        
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Qual objeto você achou ?"
        textField.returnKeyType = .done
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var addButton = ButtonDefault(text: "Adicionar", imageName: "plus", backgroundColor: .black, fontWeight: .bold)
    
    lazy var cancelButton = ButtonDefault(text: "Cancelar")
    
    lazy var addCancelStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [cancelButton, addButton])
        view.axis = .horizontal
        view.spacing = 16
        view.distribution = .fillEqually
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: AddItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(contentStack)
        addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        addButton.isEnabled = false
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        descriptionTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        contentStack.addArrangedSubview(typeSegmented)
        contentStack.addArrangedSubview(descriptionTextField)
        contentStack.addArrangedSubview(addCancelStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.topAnchor),
            contentStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func bindViewModel() {
        viewModel.isEnabled.bind { isEnabled in
            self.addButton.isEnabled = isEnabled
        }
    }
    
    @objc
    func handleCancel() {
        viewModel.didTapCancel()
    }
    
    @objc
    func handleAdd() {
        let type: ItemType = typeSegmented.selectedSegmentIndex == 0 ? .found : .lost
        let description: String = descriptionTextField.text ?? ""
        viewModel.didTapAdd(type: type, description: description)
    }
    
    @objc
    func handleTextChange() {
        viewModel.validate(text: descriptionTextField.text ?? "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

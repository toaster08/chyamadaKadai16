//
//  AddItemViewController.swift
//  chyamadaKadai13
//
//  Created by toaster on 2021/10/05.
//

import UIKit

final class InputItemViewController: UIViewController {
    enum Mode {
        case add, edit(Fruit)

        var isChecked: Bool {
            switch self {
            case .add:
                return false
            case .edit(let fruit):
                return fruit.isChecked
            }
        }
    }

    var mode: Mode?

    private(set) var result: Fruit?
    private(set) var isChecked: Bool?

    @IBOutlet private weak var itemNameTextField: UITextField!
    @IBOutlet private weak var saveBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        // オーバーライドしてからの呼び出しが行われていなかった
        super.viewDidLoad()

        // modeがModeのオプショナル型として指定されているのでオプショナルバインディング
        guard let mode = mode else {
            fatalError("mode is nil")
        }

        saveBarButtonItem.isEnabled = false
        itemNameTextField.addTarget(self,
                                    action: #selector(itemNameTextFieldEditingChanged),
                                    for: .editingChanged)

        switch mode {
        case .add:
            itemNameTextField.text = ""
        case let .edit(fruit):
            saveBarButtonItem.isEnabled = true
            itemNameTextField.text = fruit.name
        }
    }

    @IBAction private func saveItem(_ sender: Any) {
        guard let mode = mode else {
            fatalError("mode is nil")
        }

        switch mode {
        // func addItemへと連絡する
        case .add:  performSegue(withIdentifier: "AddItemSegue", sender: nil)
        // func editItemへと連絡する
        case .edit: performSegue(withIdentifier: "EditItemSegue", sender: nil)
        }
    }

    @objc private func itemNameTextFieldEditingChanged() {
        guard let mode = mode else {
            fatalError("mode is nil")
        }

        let newFruit = Fruit(
            name: itemNameTextField.text ?? "",
            isChecked: mode.isChecked
        )
        saveBarButtonItem.isEnabled = newFruit != nil
        result = newFruit
    }
}

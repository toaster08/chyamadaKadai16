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
    }
    var mode: Mode?

    private(set) var fruit: Fruit?
    private(set) var isChecked: Bool?

    @IBOutlet private weak var itemNameTextField: UITextField!
    @IBOutlet private weak var saveBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        saveBarButtonItem.isEnabled = false
        itemNameTextField.addTarget(self,
                                    action: #selector(itemNameTextFieldEditingChanged),
                                    for: .editingChanged)

        switch mode {
        case .add:
            itemNameTextField.text = ""
        case let .edit(fruit):
            saveBarButtonItem.isEnabled = true
            isChecked = fruit.isChecked
            itemNameTextField.text = fruit.name
        default:
            break
        }
    }

    @IBAction private func saveItem(_ sender: Any) {
        switch mode {
        case .add:  performSegue(withIdentifier: "AddItemSegue", sender: nil)
        case .edit: performSegue(withIdentifier: "EditItemSegue", sender: nil)
        default:
            break
        }
    }

    @objc private func itemNameTextFieldEditingChanged() {
        let fruit = Fruit(name: itemNameTextField.text ?? "", isChecked: isChecked ?? false)
        saveBarButtonItem.isEnabled = fruit.isValid
        self.fruit = fruit
    }
}

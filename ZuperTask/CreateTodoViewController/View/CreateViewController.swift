//
//  CreateViewController.swift
//  ZuperTask
//
//  Created by vinumurugan E on 19/03/22.
//

import UIKit

protocol Createprotocol {
    func updateValue(info :Info)
}


class CreateViewController: UIViewController {
    
    private var viewModel : CreateVModel!
    
    @IBOutlet weak var taskFld: UITextField!
    
    @IBOutlet weak var tagFld: UITextField!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var bottomlayout: NSLayoutConstraint!
    
    var idelegate:Createprotocol? = nil
    
    var info = Info()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CreateVModel()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        bottomlayout.constant = keyboardFrame.size.height - 90
        UIView.animate(withDuration: 0.3) {
          self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        bottomlayout.constant = 0
        UIView.animate(withDuration: 0.3) {
          self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func priorityChanged(_ sender: Any) {
        
        switch segment.selectedSegmentIndex {
        case 0 :
            self.info.priority = Priority.low
        case 1 :
            self.info.priority = Priority.medium
        default :
            self.info.priority = Priority.high
        }
    }
    

    @IBAction func createAction(_ sender: Any) {
        if isValidTodo() {
            info.author = "Test User"
            viewModel.crateTodo(withInfo: info) { (local) in
                self.info.id = local.id
                self.idelegate?.updateValue(info: self.info)
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func isValidTodo() -> Bool {
        if (self.info.title ?? "").isEmpty {
            self.showAlert(WithMessage: "Please enter todo title")
            return false
        }
        if (self.info.tag ?? "").isEmpty {
            self.showAlert(WithMessage: "Please enter todo tag")
            return false
        }
        if (self.info.priority ?? "").isEmpty {
            self.showAlert(WithMessage: "Please enter todo priority")
            return false
        }
        return true
    }
}



extension CreateViewController : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == self.taskFld {
            self.tagFld.becomeFirstResponder()
        } else if textField == self.tagFld {
            textField.resignFirstResponder()
        }
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == self.taskFld {
            info.title = textField.text ?? ""
        } else if textField == self.tagFld {
            info.tag = textField.text ?? ""
        }
    }
}

//
//  AddTaskViewController.swift
//  ThesisTracker
//
//  Created by Irfan Izudin on 10/04/22.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var newTaskField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    let pickerView = UIPickerView()
    let category = ["Book", "Implementation"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.large()]
            presentationController.prefersGrabberVisible = true
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNewTask))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissNewTask))
        
        newTaskField.returnKeyType = .done
        newTaskField.autocapitalizationType = .words
        newTaskField.autocorrectionType = .no
        newTaskField.becomeFirstResponder()
        newTaskField.delegate = self
        
        categoryField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
    }
    
    @objc func saveNewTask(){
        print(newTaskField.text, categoryField.text)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissNewTask(){
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newTaskField.resignFirstResponder()
        if let text = newTaskField.text{
            print(text)
        }
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryField.text = category[row]
        categoryField.resignFirstResponder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

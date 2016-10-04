//
//  LoginViewController.swift
//  CatRoll-SignUp
//
//  Created by Louis Tur on 9/29/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Validations
    func textFieldsAreValid() -> Bool {
        
        // 1. some set up
        let textFields: [UITextField] = [self.nameTextField, self.passwordTextField]
        let minimumLengthRequireMents: [UITextField : Int] = [
            self.nameTextField : 1,
            self.passwordTextField : 6
        ]
        // 2. iterrate over the text fields
        for textField in textFields{
        // 3. if the textfield doesn't have the minimum required characters...
            if !self.textField(textField, hasMinimumCharacters: minimumLengthRequireMents[textField]!){
        // 4. make sure that the label isn't hidden
                self.updateErrorLabel(with: "\(textField.debugId) must be at least \(minimumLengthRequireMents[textField]!) character")
        // 5. display an error to rhe user
                return false
            }
        // 6. indicate that the fields are not valid
        }
        // 7. hide the error label if all gets validated
        errorLabel.isHidden = true
        // 8. indicate that the fields are valid
        return true
    }
    
    func textField(_ textField: UITextField, hasMinimumCharacters minimum: Int) -> Bool {
        guard (textField.text?.characters.count)! < minimum else{
            return true
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // only interested in doing this validation for self.nameTextField
        // and per documentation, string can be empty if the change is a deletion
        
        if textField == self.nameTextField && string != "" {
            return self.string(string, containsOnly: CharacterSet.letters.union(CharacterSet.whitespaces))
        }
        
        return true
    }
    
    func string(_ string: String, containsOnly characterSet: CharacterSet) -> Bool {
        for character in string.utf8{
            guard characterSet.hasMember(inPlane: UInt8(character)) else{
                print("NUMBER FOUND")
                return false
            }
        }
        return true
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        print("Button did tapped")
    }
    
    
    // MARK: - UI Helper
    // (add the label update function here when the lesson calls for it)
    
    
    // MARK: - UITextFieldDelegate
    // (add delegate functions below here)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("\(textField.debugId) SHOULD BEGIN")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("\(textField.debugId) DID BEGIN")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("\(textField.debugId) SHOULD END")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\(textField.debugId) DID END")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("\(textField.debugId) SHOULD RETURN")
        _ = self.textFieldsAreValid()
        return true
    }
    
    func updateErrorLabel(with message: String) {
        if self.errorLabel.isHidden {
            self.errorLabel.isHidden = false
        }
        
        self.errorLabel.text = message
        self.errorLabel.textColor = UIColor.red
        self.errorLabel.backgroundColor = UIColor.red.withAlphaComponent(0.25)
    }
}

//
//  ViewController.swift
//  SwiftParseApp
//
//  Created by Burak Emre gündeş on 11.03.2022.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signInClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { user, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Hatalı İşlem")
                }else{
                    self.performSegue(withIdentifier: "toPlacesListVC", sender: nil)
                }
            }
            
       
        }else{
            self.makeAlert(title: "Error", message: "Email/Password?")
        }
        
    }
    @IBAction func signUpClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            let user=PFUser()
            
            user.username=emailTextField.text!
            user.password=passwordTextField.text!
            
            user.signUpInBackground { success, error in
                if error != nil{
                    self.makeAlert(title: "Error",message: error?.localizedDescription ?? "Hatalı İşlem")
                }else{
                    self.performSegue(withIdentifier: "toPlacesListVC", sender: nil)
                }
            }
        }else{
            self.makeAlert(title: "Error", message: "Email/Password?")
        }
        
    }
    
    func makeAlert(title:String,message:String){
        let alert=UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton=UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    
    }
    

}


 

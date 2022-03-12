//
//  AddPlacesViewController.swift
//  SwiftParseApp
//
//  Created by Burak Emre gündeş on 11.03.2022.
//

import UIKit

class AddPlacesViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var placeTypeTextField: UITextField!
    @IBOutlet weak var placeAtmosphere: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        placeImage.isUserInteractionEnabled=true
            let imageRecognizer=UITapGestureRecognizer(target: self, action: #selector(selectImage))
        placeImage.addGestureRecognizer(imageRecognizer)
                
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image=info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)

    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate=self
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing=true
        present(picker,animated: true,completion: nil)
        
    }
        
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        
        if placeNameTextField.text != "" && placeTypeTextField.text != "" && placeAtmosphere.text != "" {
            if placeImage.image != UIImage(named: "selectimage"){
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName=placeNameTextField.text!
                placeModel.placeType=placeTypeTextField.text!
                placeModel.placeAtmosphere=placeAtmosphere.text!
                placeModel.placeImage=placeImage.image!
                self.performSegue(withIdentifier: "toAddPlacesMapVC", sender: nil)
            }else{
                self.makeAlert(title: "Error", message: "Alanları Boş Bırakmayınız")
            }
        }
        else{
            self.makeAlert(title: "Error", message: "Alanları Boş Bırakmayınız")
        }
        
       
    }
    
    func makeAlert(title:String,message:String){
        let alert=UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton=UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
        
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

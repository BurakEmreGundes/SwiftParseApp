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
        self.performSegue(withIdentifier: "toAddPlacesMapVC", sender: nil)
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

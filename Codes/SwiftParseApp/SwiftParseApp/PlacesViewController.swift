//
//  PlacesViewController.swift
//  SwiftParseApp
//
//  Created by Burak Emre gündeş on 11.03.2022.
//

import UIKit
import Parse

class PlacesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    var placesNameArray=[String]()
    var placesIdArray=[String]()
    var selectedPlacesID:String=""

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate=self
        tableView.dataSource=self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem=UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutClicked))
        
        
        getDataFromParse()
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell=UITableViewCell()
        cell.textLabel?.text=placesNameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesNameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlacesID=placesIdArray[indexPath.row]
        performSegue(withIdentifier: "toPlacesDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlacesDetailsVC"{
            let destination=segue.destination as! PlacesDetailsViewController
            destination.chosenPlacesID=selectedPlacesID
        }
    }
    
    @objc func addButtonClicked(){
        self.performSegue(withIdentifier: "toAddPlacesVC", sender: nil)
    }
    
    @objc func logoutClicked(){
        
        PFUser.logOutInBackground { error in
            if error != nil{
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Hatalı İşlem")
            }else{
                self.performSegue(withIdentifier: "toLogoutVC", sender: nil)
            }
        }
        
    }
    
    func makeAlert(title:String,message:String){
        let alert=UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton=UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
        
    }
    
    func getDataFromParse(){
        let query=PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil{
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Hatalı İşlem")
            }else{
                if objects != nil{
                    for object in objects!{
                        if let placeName=object.object(forKey: "name") as? String{
                            self.placesNameArray.append(placeName)
                        }
                        if let placeID=object.objectId{
                            self.placesIdArray.append(placeID)
                        }
                    }
                }
                self.tableView.reloadData()
            }
        }
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

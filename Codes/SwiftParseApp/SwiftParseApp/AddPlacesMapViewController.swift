//
//  AddPlacesMapViewController.swift
//  SwiftParseApp
//
//  Created by Burak Emre gündeş on 11.03.2022.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class AddPlacesMapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    var locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager.delegate=self
        mapView.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem=UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backClicked))
        
        
        let mapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        mapRecognizer.minimumPressDuration=3
        mapView.addGestureRecognizer(mapRecognizer)
        
        
    }
    @objc func chooseLocation(gestureRecognizer:UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            let touches=gestureRecognizer.location(in: self.mapView)
            let coordinates=self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate=coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle=PlaceModel.sharedInstance.placeType
            PlaceModel.sharedInstance.placeLatitude=String(coordinates.latitude)
            PlaceModel.sharedInstance.placeLongitude=String(coordinates.longitude)
            
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span=MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func addButtonClicked(){
        let placeModel=PlaceModel.sharedInstance
        let object=PFObject(className: "Places")
        object["name"]=placeModel.placeName
        object["type"]=placeModel.placeType
        object["atmosphere"]=placeModel.placeAtmosphere
        object["latitude"]=placeModel.placeLatitude
        object["longitude"]=placeModel.placeLongitude
        
        if let imageData=placeModel.placeImage.jpegData(compressionQuality: 0.5){
            object["image"] = PFFileObject(name:"image.jpg", data: imageData)
        }
        
        object.saveInBackground { success, error in
            if error != nil{
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Hatalı İşlem")
            }else{
                self.performSegue(withIdentifier: "toPlacesListVCFromSave", sender: nil)
            }
        }
    }
    
    @objc func backClicked(){
        self.dismiss(animated: true, completion: nil)
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

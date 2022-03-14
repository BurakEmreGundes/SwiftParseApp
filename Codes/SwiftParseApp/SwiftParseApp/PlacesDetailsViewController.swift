//
//  PlacesDetailsViewController.swift
//  SwiftParseApp
//
//  Created by Burak Emre gündeş on 11.03.2022.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class PlacesDetailsViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var chosenPlacesID:String=""
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var placeAtmosphereLabel: UILabel!
    var annotationLongitude:Double!
    var annotationLatitude:Double!
    
    var locationManager=CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate=self
        mapView.delegate=self
        
        getPlace()

        // Do any additional setup after loading the view.
    }
    
    
    func getPlace(){
        let query=PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlacesID)
        query.findObjectsInBackground { objects, error in
            if error != nil{
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Hatalı İşlem")
            }else{
                if objects != nil{
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String{
                            self.placeNameLabel.text=placeName
                        }
                        if let placeType=object.object(forKey: "type") as? String{
                            self.placeTypeLabel.text=placeType
                        }
                        if let placeAtmosphere=object.object(forKey: "atmosphere") as? String{
                            self.placeAtmosphereLabel.text=placeAtmosphere
                        }
                        if let placeAnnotationLatitude = object.object(forKey: "latitude") as? String{
                            if let annotationDoubleLatitude = Double(placeAnnotationLatitude){
                                self.annotationLatitude=annotationDoubleLatitude
                            }
                        }
                        if let placeAnnotationLongitude=object.object(forKey: "longitude") as? String{
                            if let annatationDoubleLongitude=Double(placeAnnotationLongitude){
                                self.annotationLongitude=annatationDoubleLongitude
                            }
                            
                        }
                        
                        if let imageData=object.object(forKey: "image") as? PFFileObject{
                            imageData.getDataInBackground{ data, error in
                                if error == nil{
                                    if data != nil{
                                        self.imageView.image=UIImage(data: data!)
                                    }
                                }
                            }
                        }
                        
                        let annotation=MKPointAnnotation()
                        
                        let coordinate=CLLocationCoordinate2D(latitude: self.annotationLatitude, longitude: self.annotationLongitude)
                        annotation.coordinate=coordinate
                        self.mapView.addAnnotation(annotation)
                        self.locationManager.stopUpdatingLocation()
                        
                        let span=MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                        let region=MKCoordinateRegion(center: coordinate, span: span)
                        self.mapView.setRegion(region, animated: true)
                        
                    }
                }
            }
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

//
//  PlaceModel.swift
//  SwiftParseApp
//
//  Created by Burak Emre gündeş on 12.03.2022.
//

import Foundation
import UIKit

class PlaceModel{
    static let sharedInstance = PlaceModel()
    
    var placeName=""
    var placeType=""
    var placeAtmosphere=""
    var placeImage=UIImage()
    var placeLongitude=""
    var placeLatitude=""
    
    private init(){}
}

//
//  ViewController.swift
//  GEO
//
//  Created by YANGSHENG ZOU on 2016-05-25.
//  Copyright © 2016 YANGSHENG ZOU. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var pinImageView: UIImageView!
    var geoCoder:CLGeocoder = CLGeocoder.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationOnMapView() ->CLLocationCoordinate2D {
    
        let pinCenter = CGPoint(x: CGRectGetMidX(pinImageView.bounds), y: CGRectGetMidY(pinImageView.bounds))
      
        return mapView.convertPoint(pinCenter, toCoordinateFromView: pinImageView)
    }
    
    func showLoacation(){
        let coordinateInMapView = locationOnMapView()
        let location = CLLocation(latitude: coordinateInMapView.latitude, longitude: coordinateInMapView.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemark,error in
            
            if error == nil {
                var locationInfo = ""
                print(locationInfo)
                for p:CLPlacemark in placemark!{
                    if(p.country != nil){
                        locationInfo = locationInfo+p.country!+" "
                        
                        
                    }
                    if(p.administrativeArea != nil){
                        locationInfo = locationInfo+p.administrativeArea!+" "
                    }
                    
                    if(p.name != nil){
                        locationInfo = locationInfo+p.name!+" "
                    }
                    if(p.postalCode != nil){
                        locationInfo = locationInfo+p.postalCode!+" "
                    }
                    print(locationInfo)
                    self.locationLabel.text = locationInfo
                }
            }
            else{
                print(error!)
            }
        })

    }
    
    func mapView(mapView: MKMapView,
                   regionDidChangeAnimated animated: Bool){
        mapView.userInteractionEnabled = false
        showLoacation()
        mapView.userInteractionEnabled = true
    }

    @IBAction func showLocation(sender: AnyObject) {
        
        
        
    }

}


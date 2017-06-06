// ---
// Hotels JSON parser
// ---
// Author: Ilia Semenov
// Contacts: smpw@mail.ru
//

import UIKit
import MapKit

class HotelInfo: UITableViewController
{
    @IBOutlet weak var hotelAdress: UILabel!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelStars: UIImageView!
    @IBOutlet weak var hotelSuits: UILabel!
    @IBOutlet weak var hotelDistance: UILabel!
    @IBOutlet weak var hotelId: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var choosenHotel = Hotel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setData()
        mapSetting()
    }
    
    func setData()
    {
        hotelName.text = choosenHotel.name
        hotelAdress.text = choosenHotel.adress
        hotelStars.image = UIImage(named: "\(choosenHotel.stars)_stars_medium")
        hotelDistance.text = "\(choosenHotel.distance) meters"
        hotelSuits.text = "\(choosenHotel.suites.count) suits"
        hotelId.text = "\(choosenHotel.id)"
    }
    
    func mapSetting()
    {
        let location = CLLocation(latitude: choosenHotel.lat, longitude: choosenHotel.lon)
        let region: CLLocationDistance = 90
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, region * 2.0, region * 2.0)
        map.setRegion(coordinateRegion, animated: true)
        
        let pin = MKPointAnnotation()
        let pinLocation = CLLocationCoordinate2DMake(choosenHotel.lat, choosenHotel.lon)
        pin.coordinate = pinLocation
        pin.title = choosenHotel.name
        map.addAnnotation(pin)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}


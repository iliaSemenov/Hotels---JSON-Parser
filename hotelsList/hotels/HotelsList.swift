// ---
// Hotels JSON parser
// ---
// Author: Ilia Semenov
// Contacts: smpw@mail.ru
//

import UIKit

class HotelsList: UITableViewController
{
    let fetch = Fetch()
    let sorter = Sorting()
    
    var hotels: [Hotel] = []
    var ids: [Int] = []
    var choosenHotel = Hotel()
    var numberOfChoosenHotel = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        startSettings()
        chooseSorting()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ids.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let hotelCell = tableView.dequeueReusableCell(withIdentifier: "hotelCell", for: indexPath) as! HotelCell
        
        hotelCell.indexOfCell = indexPath.row
        hotelCell.hotel = hotels[indexPath.row]
        hotelCell.hotelName.text = hotels[indexPath.row].name
        hotelCell.hotelStars.image = UIImage(named: "\(hotels[indexPath.row].stars)"+"_stars_medium")
        hotelCell.hotelDistance.text = "\(hotels[indexPath.row].distance) m."
        hotelCell.fetchImage(indexOfUrl: indexPath.row)
        
        let selectedView = UIView(frame: CGRect(x: 0, y: 0, width: hotelCell.frame.width, height: hotelCell.frame.height))
        selectedView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        hotelCell.selectedBackgroundView = selectedView
        
        return hotelCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        choosenHotel = hotels[indexPath.row]
        numberOfChoosenHotel = indexPath.row
        performSegue(withIdentifier: "infoSegue", sender: self)
    }
    
    func startSettings()
    {
        hotels.removeAll()
        ids.removeAll()
        
        ids = fetch.fetchID()
        for i in 0..<ids.count
        {
            hotels.append(fetch.fetchHotelData(index: i))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "infoSegue"
        {
            let destinationViewController = segue.destination as! HotelInfo
            destinationViewController.choosenHotel = hotels[numberOfChoosenHotel]
        }
    }
    
    func chooseSorting()
    {
        let userDefaults = UserDefaults.standard
        if userDefaults.value(forKey: "sort") != nil
        {
            let choosenSort = userDefaults.value(forKey: "sort")! as! Int
            switch choosenSort
            {
                case 0: startSettings()
                case 1: hotels = sorter.distanceSort(array: hotels)
                case 2: hotels = sorter.suitesSort(array: hotels)
                case 3: hotels = sorter.starsSort(array: hotels)
                case 4: hotels = sorter.nameSort(array: hotels)
                default: print("Error for choose sorting type (start)")
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}


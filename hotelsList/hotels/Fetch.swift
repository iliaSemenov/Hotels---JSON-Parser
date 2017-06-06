// ---
// Hotels JSON parser
// ---
// Author: Ilia Semenov
// Contacts: smpw@mail.ru
//

import Foundation
import SwiftyJSON

class Fetch
{
    var ids: [Int] = []
    var hotels: [Hotel] = []
    
    func fetchID() -> [Int]
    {
        ids.removeAll()
        let queue = DispatchQueue.global(qos: .userInitiated)
        let url = URL(string: "https://raw.githubusercontent.com/iliaSemenov/Hotels-JSON-Parser/master/json_data/hotels/hotels.json")
        queue.sync
            {
                if let data = try? Data(contentsOf: url!)
                {
                    let json = JSON(data: data)
                    for index in 0..<json.count
                    {
                        ids.append(json[index]["id"].int!)
                    }
                }
                else
                {
                    print("Can't load hotels Ids")
                }
        }
        return ids
    }
    
    func fetchHotelData(index: Int) -> Hotel
    {
        hotels.removeAll()
        let newHotel = Hotel()
        let url = URL(string: "https://raw.githubusercontent.com/iliaSemenov/Hotels-JSON-Parser/master/json_data/hotels_full_info/" + "\(ids[index])" + ".json")
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.sync
            {
                if let data = try? Data(contentsOf: url!)
                {
                    let json = JSON(data: data)
                    
                    newHotel.name = json["name"].string!
                    newHotel.id = json["id"].int!
                    newHotel.adress = json["address"].string!
                    newHotel.distance = json["distance"].int!
                    newHotel.stars = json["stars"].int!
                    newHotel.suites = self.convertStringToArray(text: json["suites_availability"].string!)
                    if json["image"].string! != ""
                    {
                        newHotel.image = "https://github.com/iliaSemenov/Hotels-JSON-Parser/raw/master/json_data/images/" + json["image"].string!
                    }
                    else
                    {
                        newHotel.image = ""
                    }
                    newHotel.lat = json["lat"].double!
                    newHotel.lon = json["lon"].double!
                }
                else
                {
                    print("Can't load hotel data")
                }
        }
        return newHotel
    }
    
    func convertStringToArray(text: String) -> [Int]
    {
        let correctedText = text.replacingOccurrences(of: ":", with: ",")
        let StringRecordedArr = correctedText.components(separatedBy: ",")
        return StringRecordedArr.map { Int($0)!}
    }
}

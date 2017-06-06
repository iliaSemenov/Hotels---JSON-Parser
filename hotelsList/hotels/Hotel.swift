// ---
// Hotels JSON parser
// ---
// Author: Ilia Semenov
// Contacts: smpw@mail.ru
//

import UIKit

class Hotel
{
    var name = ""
    var adress = ""
    var distance = Int()
    var stars = Int()
    var image = ""
    var id = Int()
    var suites: [Int] = []
    var lat = Double()
    var lon = Double()
    
    func loadHotelImage() -> UIImage
    {
        var resultImage = UIImage()
        do
        {
            let imageData = try Data(contentsOf: URL(string: "https://github.com/iMofas/ios-android-test/raw/master/" + image)!)
            resultImage = UIImage(data: imageData)!
        }
        catch
        {
            resultImage = UIImage(named: "no_photo")!
        }
        return resultImage
    }
}

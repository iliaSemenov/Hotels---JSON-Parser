// ---
// Hotels JSON parser
// ---
// Author: Ilia Semenov
// Contacts: smpw@mail.ru
//

import UIKit
import SwiftyJSON

class HotelCell: UITableViewCell
{
    var indexOfCell = Int()
    var hotel = Hotel()
    
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var hotelStars: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelDistance: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    
    func fetchImage(indexOfUrl: Int)
    {
        if hotel.image != ""
        {
            indicator.startAnimating()
            let queueUtility = DispatchQueue.global(qos: .userInitiated)
            let url = URL(string: hotel.image)!
            queueUtility.async
                {
                    if let data = try? Data(contentsOf: url)
                    {
                        DispatchQueue.main.async
                            {
                                if indexOfUrl == self.indexOfCell
                                {
                                    self.hotelImage.image = UIImage(data: data)
                                    self.indicator.stopAnimating()
                                }
                        }
                    }
                    else
                    {
                        print("Can't load image for hotel: \(self.hotel.name)")
                        self.hotelImage.image = UIImage(named: "no_photo")
                        self.indicator.stopAnimating()
                    }
            }
        }
        else
        {
            hotelImage.image = UIImage(named: "no_photo")
            indicator.stopAnimating()
        }
    }
}

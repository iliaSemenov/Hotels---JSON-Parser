// ---
// Hotels JSON parser
// ---
// Author: Ilia Semenov
// Contacts: smpw@mail.ru
//

import UIKit

class CustomNavigationBar: UINavigationBar
{
    override func sizeThatFits(_ size: CGSize) -> CGSize
    {
        let size = CGSize(width: (self.superview?.frame.size.width)!, height: 50)
        return size
    }
}

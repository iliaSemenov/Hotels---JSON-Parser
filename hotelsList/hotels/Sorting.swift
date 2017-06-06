// ---
// Hotels JSON parser
// ---
// Author: Ilia Semenov
// Contacts: smpw@mail.ru
//

import UIKit

class Sorting: UITableViewController
{
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if userDefaults.value(forKey: "sort") != nil
        {
            for _ in 0..<5
            {
                cell.accessoryType = .none
            }
            
            if userDefaults.value(forKey: "sort") != nil
            {
                let choosenSort = userDefaults.value(forKey: "sort")! as! Int
                let cellName = "cell" + "\(choosenSort)"
                if cell.reuseIdentifier == cellName
                {
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)

        for index in 0..<5
        {
            tableView.cellForRow(at: [0,index])?.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        saveDefaults(rowNumber: indexPath.row)
    }

    func distanceSort(array: [Hotel]) -> [Hotel]
    {
        return array.sorted(by: { $0.distance < $1.distance })
    }
    
    func suitesSort(array: [Hotel]) -> [Hotel]
    {
        return array.sorted(by: {$0.suites.count < $1.suites.count})
    }
    
    func starsSort(array: [Hotel]) -> [Hotel]
    {
        return array.sorted(by: {$0.stars < $1.stars})
    }
    
    func nameSort(array: [Hotel]) -> [Hotel]
    {
        return array.sorted(by: {$0.name < $1.name})
    }
    
    func saveDefaults(rowNumber: Int)
    {
        userDefaults.set(rowNumber, forKey: "sort")
        userDefaults.synchronize()
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


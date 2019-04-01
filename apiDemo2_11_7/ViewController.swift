
import UIKit
import Alamofire
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblCountry: UITableView!
    var arrCountry = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//Set Data to TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrCountry.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblCountry.dequeueReusableCell(withIdentifier: "countryCell") as! countryCell
        
        let arrCountryName = (arrCountry.value(forKey: "name") as! NSArray)
        cell.lblCountryName.text = arrCountryName.object(at: indexPath.row) as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
    
        let arrCountryName = (arrCountry.value(forKey: "capital") as! NSArray)
        print(arrCountryName.object(at: indexPath.row) as! String)
    }
 
//Get Dat From API
    
    func getData() -> Void{
        let strURL = "https://restcountries.eu/rest/v2/all"
        print(strURL)
        AFWrapper.requestGETURL(strURL, success: {
            (JSONResponse) -> Void in
            if let resData = JSONResponse.arrayObject{
                //print(resData)
                let myArray = resData as NSArray
                self.arrCountry = myArray.mutableCopy() as! NSMutableArray
                self.printData()
                self.tblCountry.reloadData()
            }
        })
        {
            (error) -> Void in
        }
        
    }
//Print Data From API into Log
    func printData() {
        for i in 0..<arrCountry.count {
            let arrCountryName = (arrCountry.value(forKey: "name") as! NSArray)
            print(arrCountryName.object(at: i) as! String)
        }
    }
}


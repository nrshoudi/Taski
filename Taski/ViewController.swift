
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var menuView: UIViewX!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pencilButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var clockButton: UIButton!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var longDateLabel: UILabel!
    @IBOutlet weak var weatherImageIcon: UIImageView!
    @IBOutlet weak var tempretureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    var tableData: [Model] = []
    var DayWeatherData: DayWeatherModel?
    
    //location
    var locationManager = CLLocationManager()
    var userLocaitonCoordinate = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    
        setLocation()
        setDate()
        
        
        
        Data.getData(completion: { (data) in
        self.tableData = data
        self.tableView.reloadData()
        
        self.animateTableCells()
            
        }) { (err) in
            if let err = err{
                print("Error: \(err)")
            }
        }
        
        
        
        closeMenu()
        setupAnimatedControls()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let lat = "\(locValue.latitude)"
        let long = "\(locValue.longitude)"
        Data.getWeatherData(latitude: lat, longitude: long, completion: { (data) in
            if let tempreture = data.main?.temp {
                let temp_celsius = Int(tempreture - 273.15)
               self.tempretureLabel.text = "\(temp_celsius)°"
                self.weatherImageIcon.image = UIImage(named: "sun")
            }
          self.cityLabel.text = data.name
            
        }) { (error) in
          print("Error get data")
        }
    }
    
    func setLocation() {

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    func setDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd,YYY"
        let formatterDate = formatter.string(from: date)
        self.longDateLabel.text = formatterDate
        
        formatter.dateFormat = "EEEE"
        let dayName = formatter.string(from: date)
        
        self.dayLabel.text = dayName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.dayView.transform = .identity
            self.weatherView.transform = .identity
        }) { (success) in
            
        }
    }
    
    @IBAction func menuTapped(_ sender: FloatingActionButton) {
        UIView.animate(withDuration: 0.3, animations: {
            if self.menuView.transform == .identity {
                self.closeMenu()
            } else {
                self.menuView.isHidden = false
                self.menuView.transform = .identity
            }
        })
        
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            if self.menuView.transform == .identity {
                self.pencilButton.transform = .identity
                self.chatButton.transform = .identity
                self.clockButton.transform = .identity
            }
            })
        
    }
    
    func animateTableCells() {
        let cells = tableView.visibleCells
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        }
        
        var delay = 0.5
        for cell in cells {
            UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = .identity
            })
            
            delay += 0.15
        }
    }
    
    func closeMenu() {
        
        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        pencilButton.transform = CGAffineTransform(translationX: 0, y: 15)
        chatButton.transform = CGAffineTransform(translationX: 11, y: 11)
        clockButton.transform = CGAffineTransform(translationX: 15, y: 0)
    }
    
    func setupAnimatedControls() {
        dayView.transform = CGAffineTransform(translationX: -dayView.frame.width, y: 0)
        weatherView.transform = CGAffineTransform(translationX: weatherView.frame.width, y: 0)
    }
    
    @IBAction func clockButtonAction(_ sender: UIButton) {
        let alert = CustomAlert(title: "Reminder", image: UIImage(named: "clock")!)
        alert.show(animated: true)
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = tableData[indexPath.row]
        var cell: TableViewCell!
        
        if model.images.count > 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellWithImages") as? TableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as? TableViewCell
        }
        
        cell.setup(model: tableData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = tableData[indexPath.row]
        
        if model.images.count > 0 {
            return 100
        }
        
        return 70
    }
}
